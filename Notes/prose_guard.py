#!/usr/bin/env python3
r"""prose_guard.py — assert that a prose-only edit of a .tex file changed only prose.

Usage:
    python3 Notes/prose_guard.py OLD.tex NEW.tex          # one file
    python3 Notes/prose_guard.py --git REV -- FILE...     # compare FILE to git REV:FILE

Exit 0 if every invariant holds, 1 otherwise, printing the first mismatches.

Invariants (see Notes/STYLE.md, "What never changes"):
  1. Display math blocks (equation, equation*, align, align*, gather, gather*,
     multline, multline*, eqnarray, \[ \]) — identical sequence, byte for byte
     after whitespace normalisation.
  2. Inline math $...$ — identical multiset after whitespace normalisation.
  3. Numbers in the prose (any token matching [0-9][0-9.,]*) — identical multiset.
  4. \label, \ref, \eqref, \cref, \cite*, \citep, \citet, \citealt, \mathlink,
     \solnlink, \href, \includegraphics, \input, \annot — identical multiset of
     the full macro call (name + braces).
  5. Section-level structure: \chapter, \section, \subsection, \subsection*,
     \paragraph — identical sequence of (macro, title).
  6. Box environments annotation/derivation/bridge/keybox/aside — identical
     count per kind, and identical sequence of titles.
  7. Comment lines (% ...) are ignored on both sides.
"""
import re
import subprocess
import sys
from collections import Counter

DISPLAY_ENVS = r"((?:equation|align|gather|multline|eqnarray|alignat|flalign)\*?)"
BOX_ENVS = ("annotation", "derivation", "bridge", "keybox", "aside")
MACROS = (r"label|ref|eqref|cref|Cref|cite|citep|citet|citealt|citealp|citeauthor|citeyear"
          r"|mathlink|solnlink|href|includegraphics|input|include|annot")


def strip_comments(s: str) -> str:
    out = []
    for line in s.splitlines():
        # keep escaped \% ; drop from an unescaped % to end of line
        i = 0
        res = []
        while i < len(line):
            c = line[i]
            if c == "\\" and i + 1 < len(line):
                res.append(line[i:i + 2]); i += 2; continue
            if c == "%":
                break
            res.append(c); i += 1
        out.append("".join(res))
    return "\n".join(out)


def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def display_blocks(s: str):
    pat = re.compile(r"\\begin\{" + DISPLAY_ENVS + r"\}(.*?)\\end\{\1\}", re.S)
    blocks = [norm(m.group(0)) for m in pat.finditer(s)]
    blocks += [norm(m.group(0)) for m in re.finditer(r"(?<!\\)\\\[(.*?)(?<!\\)\\\]", s, re.S)]
    return blocks


def without_display(s: str) -> str:
    s = re.sub(r"\\begin\{" + DISPLAY_ENVS + r"\}(.*?)\\end\{\1\}", " ", s, flags=re.S)
    s = re.sub(r"(?<!\\)\\\[(.*?)(?<!\\)\\\]", " ", s, flags=re.S)
    return s


def inline_math(s: str):
    s = without_display(s)
    # $$...$$ first, then $...$ (not \$)
    out = [norm(m.group(0)) for m in re.finditer(r"\$\$(.*?)\$\$", s, re.S)]
    s = re.sub(r"\$\$(.*?)\$\$", " ", s, flags=re.S)
    out += [norm(m.group(0)) for m in re.finditer(r"(?<!\\)\$(.+?)(?<!\\)\$", s, re.S)]
    return out


def prose_only(s: str) -> str:
    s = without_display(s)
    s = re.sub(r"\$\$(.*?)\$\$", " ", s, flags=re.S)
    s = re.sub(r"(?<!\\)\$(.+?)(?<!\\)\$", " ", s, flags=re.S)
    return s


def numbers(s: str):
    p = prose_only(s)
    # drop macro arguments that are references/paths (labels, file names, cites)
    p = re.sub(r"\\(" + MACROS + r")\*?(\[[^\]]*\])?\{[^}]*\}(\{[^}]*\})?", " ", p)
    # drop environment option brackets (\begin{itemize}[leftmargin=1.2em], [nosep], [label=(\alph*)])
    p = re.sub(r"\\begin\{[a-zA-Z*]+\}(\[[^\]]*\])", r"\\begin{x}", p)
    return [t.rstrip(".,") for t in re.findall(r"(?<![A-Za-z_\\])[0-9][0-9.,]*", p)]


def macros(s: str):
    return [norm(m.group(0)) for m in
            re.finditer(r"\\(" + MACROS + r")\*?(\[[^\]]*\])?\{[^}]*\}(\{[^}]*\})?", s)]


def headings(s: str):
    return [(m.group(1), norm(m.group(2))) for m in
            re.finditer(r"\\(chapter|section|subsection|subsubsection|paragraph)\*?\{((?:[^{}]|\{[^{}]*\})*)\}", s)]


def boxes(s: str):
    seq = []
    for m in re.finditer(r"\\begin\{(" + "|".join(BOX_ENVS) + r")\}(\[((?:[^\[\]]|\[[^\]]*\])*)\])?", s):
        seq.append((m.group(1), norm(m.group(3) or "")))
    return seq


def compare(old: str, new: str, name: str) -> int:
    old, new = strip_comments(old), strip_comments(new)
    fails = 0

    def seq_check(label, a, b):
        nonlocal fails
        if a != b:
            fails += 1
            print(f"FAIL [{name}] {label}: sequence differs ({len(a)} vs {len(b)})")
            for i, (x, y) in enumerate(zip(a, b)):
                if x != y:
                    print(f"   first difference at index {i}:\n     OLD: {str(x)[:160]}\n     NEW: {str(y)[:160]}")
                    break
            else:
                extra = a[len(b):] or b[len(a):]
                print(f"   extra on {'OLD' if len(a) > len(b) else 'NEW'}: {str(extra[0])[:160]}")

    def set_check(label, a, b):
        nonlocal fails
        ca, cb = Counter(a), Counter(b)
        if ca != cb:
            fails += 1
            lost = list((ca - cb).elements())[:5]
            gained = list((cb - ca).elements())[:5]
            print(f"FAIL [{name}] {label}: multiset differs")
            if lost:
                print(f"   only in OLD: {lost}")
            if gained:
                print(f"   only in NEW: {gained}")

    seq_check("display math", display_blocks(old), display_blocks(new))
    set_check("inline math", inline_math(old), inline_math(new))
    set_check("numbers in prose", numbers(old), numbers(new))
    set_check("labels/refs/cites/links", macros(old), macros(new))
    seq_check("headings", headings(old), headings(new))
    seq_check("box environments", boxes(old), boxes(new))
    if fails == 0:
        print(f"PASS [{name}] prose-only edit: {len(display_blocks(new))} display blocks, "
              f"{len(inline_math(new))} inline math, {len(numbers(new))} numbers, "
              f"{len(macros(new))} refs/cites/links, {len(boxes(new))} boxes unchanged")
    return fails


def main(argv):
    if len(argv) >= 4 and argv[1] == "--git":
        rev = argv[2]
        files = argv[4:] if argv[3] == "--" else argv[3:]
        total = 0
        for f in files:
            old = subprocess.run(["git", "show", f"{rev}:{f}"], capture_output=True, text=True, check=True).stdout
            new = open(f, encoding="utf-8").read()
            total += compare(old, new, f)
        sys.exit(1 if total else 0)
    if len(argv) == 3:
        old = open(argv[1], encoding="utf-8").read()
        new = open(argv[2], encoding="utf-8").read()
        sys.exit(1 if compare(old, new, argv[2]) else 0)
    print(__doc__)
    sys.exit(2)


if __name__ == "__main__":
    main(sys.argv)
