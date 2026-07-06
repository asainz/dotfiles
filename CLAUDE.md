# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A macOS dotfiles setup that automates shell environment, tool configuration, and system preferences via symlinks and shell scripts. There is no build system — everything is plain shell scripts.

## Running setup

```sh
# Full setup (run from repo root)
./setup.sh

# Individual scripts can be run directly
./scripts/shell.sh    # symlinks + runtime installs (mise)
./scripts/brew.sh     # Homebrew packages
./scripts/cask.sh     # macOS apps
./scripts/macos.sh    # macOS system defaults
./scripts/dock.sh     # Dock layout
```

## Linting

```sh
# Lint all shell scripts (CI does this automatically)
shellcheck scripts/*.sh dotfiles/.zshrc dotfiles/.zprofile
```

ShellCheck runs on every push via `.github/workflows/lint.yml`. Fixes should pass ShellCheck.

## Architecture

### Symlinking strategy

`scripts/shell.sh` is the core script. It contains a `symlink()` helper that skips existing symlinks and refuses to overwrite non-symlinks, making it safe to re-run. All dotfiles and configs flow through symlinks:

- `dotfiles/.*` → `~/` (`.zshrc`, `.aliases`, `.gitconfig`, etc.)
- `configs/<tool>/` → appropriate XDG or app-specific paths
- Ghostty config goes to `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`

### Shell loading order

1. `.zprofile` — sets up Homebrew, mise, and PATH for login shells
2. `.zshrc` — sources plugins (via Antidote), loads `.aliases`, configures FZF/zoxide
3. `.zsh_plugins.txt` — Antidote plugin list (OMZ-compatible)

### Runtime management

`mise` manages all language runtimes (Go, Node LTS, Bun, Deno, Python, Ruby, Rust). Versions are pinned in `configs/mise/config.toml`. The `shell.sh` script runs `mise install` automatically.

### Key config locations

| Config | Source | Destination |
|--------|--------|-------------|
| Starship prompt | `configs/starship/starship.toml` | `~/.config/starship.toml` |
| Ghostty terminal | `configs/ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |
| Biome linter | `configs/biome/biome.json` | `~/biome.json` |
| mise runtimes | `configs/mise/config.toml` | `~/.config/mise/config.toml` |
| branchpilot | `configs/branchpilot/branchpilot.toml` | `~/.config/branchpilot.toml` |
| Claude Code | `configs/agents/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| Claude Code rules | `configs/agents/AGENTS.md` | `~/.claude/AGENTS.md` |
| Codex | `configs/agents/AGENTS.md` | `~/.codex/AGENTS.md` |

### Aliases

`.aliases` contains 150+ aliases. Key patterns:
- Git: `g`, `gs`, `gc`, `gp`, `gl`, etc. (wrappers around git with common flags)
- Navigation: `..`, `...`, uses `zoxide` for smart `z` command
- CLI replacements: `ls`/`ll`/`la` → `eza`; `cat` → `bat`; `find` → `fd`

### Git configuration

`.gitconfig` is comprehensive:
- Uses `delta` as pager for diffs
- Uses Kaleidoscope for difftool/mergetool
- Pull with rebase by default, auto-stash enabled
- Loads `~/.gitconfig-gh` conditionally for GH projects
- 40+ git aliases defined

## Conventions

- Scripts use `#!/usr/bin/env bash` and are checked with ShellCheck
- New symlinks belong in `scripts/shell.sh` using the existing `symlink()` helper
- New Homebrew packages go in `scripts/brew.sh` (formulas) or `scripts/cask.sh` (casks)
- New tool configs go in `configs/<toolname>/` with a symlink wired up in `shell.sh`
- The `dotfiles/` directory is reserved for files that live directly at `~/`
