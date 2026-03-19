# Default Repository Preferences

Reusable conventions for setting up new repositories. Apply these as defaults when starting any new project with Claude Code.

---

## Always Include

1. **`CLAUDE.md`** — Project context file at the repo root. Contains: project overview, directory structure, key conventions, common commands, important reminders.

2. **`PROGRESS_LOG.md`** — Timestamped work log updated after completing significant milestones. Format: `## YYYY-MM-DD — Description` followed by bullet points.

3. **`.gitignore`** — Must exclude:
   - Copyrighted source documents (textbooks, papers, proprietary data)
   - Secrets and credentials (`.env`, `credentials.json`, API keys)
   - OS files (`.DS_Store`)
   - Build artifacts and temporary files
   - Editor-specific files (`.vscode/`, `.idea/`, `*.swp`)
   - Claude Code local settings (`.claude/settings.local.json`)

4. **Thorough code commenting** — Every file should have:
   - Header block explaining purpose, inputs, outputs
   - Inline comments for non-obvious logic
   - References to source material where applicable (textbook equations, paper sections)

## Repository Organization

- Group files by topic/module, not by file type
- Use consistent naming: `snake_case` for files, numbered prefixes for ordered modules
- Keep a clear separation between source code, generated output, and reference materials
- Include a build/run script when compilation steps are needed

## Git Practices

- Meaningful commit messages describing the "why" not just the "what"
- Commit after completing each logical unit of work (one module, one feature)
- Never commit copyrighted materials, secrets, or large binary files
- Use `.gitkeep` in empty directories that need to be tracked

## Documentation

- README or CLAUDE.md should enable someone to understand the project in < 5 minutes
- Include a table of contents or module listing for multi-part projects
- Document dependencies and how to install them
- Include example commands for common operations
