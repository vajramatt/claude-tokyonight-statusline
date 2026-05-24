# Claude Code TokyoNight Status Bar

Dense, pretty status bar for [Claude Code](https://claude.com/claude-code) — TokyoNight Night palette, designed to pair with [Ghostty](https://ghostty.org/) terminal.

```
 my-project  Sonnet 4.6 ▏  main ▏ in74k out847 ▏ ⏱ 10m ▏ ▼74k/▲239 ▏ $0.80 ctx37%
```

## What it shows

| Field | Source |
|---|---|
| Project | `basename` of `cwd` |
| Model | `.model.display_name` |
| Git branch | `git branch --show-current` |
| Tokens in/out | Session totals from context window |
| ⏱ Session time | `.cost.total_duration_ms` |
| ▼/▲ Cache | Cache read / cache creation (current turn) |
| $ Cost | `.cost.total_cost_usd` cumulative |
| ctx% | Context window used percentage |

## Install

```bash
git clone https://github.com/vajramatt/claude-tokyonight-statusline
cd claude-tokyonight-statusline
./install.sh
```

Restart Claude Code or open `/hooks` to load.

## Manual install

1. Copy `statusline.sh` to `~/.claude/hooks/statusline.sh`
2. `chmod +x ~/.claude/hooks/statusline.sh`
3. Add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/Users/YOU/.claude/hooks/statusline.sh",
    "refreshInterval": 30
  }
}
```

## Requirements

- macOS or Linux
- [Claude Code](https://claude.com/claude-code)
- `jq` — `brew install jq` on macOS, `apt install jq` on Debian
- Terminal with 24-bit color (Ghostty, iTerm2, kitty, WezTerm, recent Terminal.app)

## Color mapping (TokyoNight Night)

| Element | Hex | Color |
|---|---|---|
| Project | `#bb9af7` | purple |
| Model | `#7dcfff` | sky blue (dim) |
| Branch | `#9ece6a` | green |
| Tokens in | `#7aa2f7` | blue |
| Tokens out | `#e0af68` | yellow |
| Time / cache read | `#73daca` | teal |
| Cache write | `#ff9e64` | orange |
| Cost | `#f7768e` | red |
| Separators | `#565f89` | comment gray |

## Customize

Edit the color constants at the bottom of `statusline.sh`. Format: `\033[38;2;R;G;Bm` (24-bit ANSI).

To swap palettes, replace all nine `\033[38;2;R;G;B` values with your theme's hex-to-RGB.

## License

MIT
