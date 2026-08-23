# common rules (all modes)

## Temp files: prefer `mystuff/tmp`

When you need a scratch/temp location for throwaway files, prefer
`mystuff/tmp/` inside the current project instead of `/tmp`.

- Use `<project-root>/mystuff/tmp/` whenever a project root exists.
- Create it on demand: `mkdir -p mystuff/tmp` (it's covered by
  `.gitignore_global`'s `**/mystuff/`, so it stays out of version control).
- If there is no project (e.g. running outside any repo) and a project-local
  temp dir genuinely doesn't make sense, fall back to `/tmp`.
