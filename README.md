# Modular Zsh Configuration ⚙️✨

A lightweight, modular Zsh configuration framework that keeps your shell setup tidy, composable, and easy to manage. Designed for developers who like small, focused config files and simple plugin handling — with a dash of humor and a lot of productivity. 🚀

## Features 🎯

- Modular configuration: split settings into `conf.d/*.zsh` for clear separation of concerns.
- Plugin management: auto-clones common plugins (zsh-autosuggestions, zsh-syntax-highlighting) into `plugins/`.
- Function loader: drop custom functions into `functions/` and have them autoloaded.
- Safe install/uninstall: installer backs up existing `~/.zshrc` and uninstaller can restore it.
- Friendly defaults: sensible history, completion, keybindings, and prompt integration.

## Tech Stack 🧰

- Shell scripts: `bash` for installer/uninstaller
- Zsh config snippets: `conf.d/*.zsh` and `functions/` for modular runtime
- Optional tools integrated: `starship`, `fastfetch`, `lsd`,

## Quick Install ✅

Run the installer from the repo root (it will copy config files to `~/.zsh`, install plugins into `~/.zsh/plugins`, and write a bootstrap `~/.zshrc`):

```bash
# from this project root
./install.sh
```

Notes:
- The script requires `zsh` and `git` to be available on your PATH.
- If a previous `~/.zshrc` is detected and not managed by this installer, it will be backed up to `~/.zshrc.bak`.
- If a previous `~/.zshrc` is detected the installer will compare it to the project's bootstrap:
- If the files are identical, the installer will proceed without creating a backup.
- If they differ, the existing `~/.zshrc` will be preserved by creating a backup at `~/.zshrc.bak` and you will be prompted before any overwrite.

## Uninstall 🧹

To remove the modular config and restore a backed-up `~/.zshrc` (if present):

```bash
./uninstall.sh
```

You will be prompted to confirm the removal.

## Usage & Customization 🛠️

- Add global environment tweaks in `conf.d/00-env.zsh`.
- Tweak core behavior in `conf.d/10-core.zsh` (history, completions, options).
- Manage plugin loading in `conf.d/20-plugins.zsh`.
- Add aliases in `conf.d/30-aliases.zsh`.
- Set keybindings in `conf.d/40-keybindings.zsh`.
- Configure prompt/themes in `conf.d/50-themes.zsh`.
- Drop reusable shell functions into `functions/` to have them autoloaded.

After changes, reload your shell with:

```bash
exec zsh
```

## Folder structure 📁

- `install.sh` — installer script
- `uninstall.sh` — uninstaller script
- `conf.d/` — modular zsh config snippets
- `functions/` — autoloadable shell functions
- `plugins/` — auto-cloned plugin repositories.

## Contributing 🤝

Small tweaks, PRs, and suggestions are welcome. Keep changes focused and modular — just like this config. If you add new modules, please add a short comment header describing intent.

## License 📝

Use it, adapt it, and have fun. No warranty — shells are powerful and demands respect. 🐚

Happy zshing! 😄