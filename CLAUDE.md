# claude-tokyonight-statusline — house rules

A dense, pretty status bar for **Claude Code** — TokyoNight Night palette, built to pair with
Ghostty. The whole thing is one bash script (`statusline.sh`) plus an installer (`install.sh`).
Public repo, MIT-licensed, meant for other people to clone and use. `README.md` is the
human-facing overview.

## This repo is PUBLIC and distributable — keep it clean

`github.com/vajramatt/claude-tokyonight-statusline` is public and MIT. It's someone-else's-machine
software:

- **No secrets, no real usernames/paths, no machine-specific config.** The README's manual-install
  JSON uses `/Users/YOU/…` as a placeholder — keep it a placeholder; never paste a real home path.
- No hard dependencies beyond **`jq`** and a 24-bit-color terminal. Don't add a framework, a
  language runtime, or a package manager — it must stay a single copy-anywhere shell script.
- Cross-platform (macOS **and** Linux). Don't add macOS-only calls to the hot path.

## Fail soft — a status line must never error

`statusline.sh` reads Claude Code's status JSON on **stdin** and prints one line. It runs on every
refresh, so robustness beats features:

- Every field is extracted through `jq_val` with `// empty` and a fallback (`jq` missing → empty,
  never a crash). Preserve that. Missing/renamed JSON fields must degrade to a placeholder
  (`—`, `0`, empty), not a broken line or a stderr spew.
- Keep it fast and side-effect-free: read stdin, compute, print. No network, no writes, no prompts.
- If Claude Code changes its status-JSON schema, update the `jq` paths (note the existing
  `.cwd // .workspace.current_dir` and `.git.branch // .git_branch` fallbacks — add new shapes the
  same way rather than replacing the old ones).

## Palette & fields are the product — keep README in sync

- The nine TokyoNight Night color constants live at the **bottom** of `statusline.sh`
  (`\033[38;2;R;G;Bm` 24-bit ANSI). The README documents each element→hex mapping and the field→
  source table. If you change a color or add/remove a field, **update the README table in the same
  commit** — the mapping table is part of what people rely on.
- The context gauge is a green→yellow→orange→red gradient; the percentage takes the last filled
  cell's color (orange ≈ time to `/compact`). Keep that semantic if you touch the gauge.

## Shared with the dotfiles repo — keep them in sync

`statusline.sh` here is **byte-identical** to `claude/hooks/statusline.sh` in
`~/code/dotfiles` (which symlinks to Matt's live `~/.claude/hooks/statusline.sh`). They're two
homes for the same file. Change one → mirror it to the other in the same session, or they drift.
Editing the dotfiles copy changes Matt's running statusline immediately; this repo is the public
distributable of the same script.

## Install script

`install.sh` copies `statusline.sh` to `~/.claude/hooks/`, `chmod +x`, and patches
`~/.claude/settings.json`'s `statusLine` block with `jq` (backing up to `settings.json.bak` first,
leaving the rest of the file untouched). Honor `CLAUDE_CONFIG_DIR`. Keep it safe to re-run and keep
the backup.

## Git identity

Commit as the GitHub **noreply** identity —
`Matthew Williamson <220089294+vajramatt@users.noreply.github.com>` (already the repo's local
config). Never a personal email in a public repo. Don't commit without Matt asking.
