# Документация dotfiles (dotnetsh)

Шпаргалки и гайды по конфигурации из этого репозитория.

| Файл | Содержание |
|------|------------|
| [tmux-guide.md](./tmux-guide.md) | tmux: окна, панели, vim-tmux-navigator |
| [nvim-guide.md](./nvim-guide.md) | Neovim: буферы, сплиты, плагины, LSP |
| [kulala-guide.md](./kulala-guide.md) | Kulala: HTTP-клиент (.http / .rest) |
| [ranger-guide.md](./ranger-guide.md) | Ranger: навигация, fzf, rifle, операции с файлами |
| [cheatsheet.md](./cheatsheet.md) | Одностраничные шпаргалки (tmux + nvim + ranger) |
| [../nvim/plugin-notes.md](../nvim/plugin-notes.md) | Заметки по узким плагинам (tdd, dbout, deep-symbols) |

## Где лежит конфиг

| Компонент | В репо | После установки |
|-----------|--------|-----------------|
| tmux | `.tmux.conf` | `~/.tmux.conf` |
| Neovim | `nvim/` | `~/.config/nvim/` |
| zsh | `.zshrc`, `.zshenv` | `~/` |
| Alacritty | `alacritty.toml` | `~/.config/alacritty/` |
| Ranger | `config/ranger/` | `~/.config/ranger/` |

Установка ranger-конфига: `stow -t ~/.config config` из корня репо (или `./scripts/install-stow.sh`).

Перезагрузка tmux: `tmux source-file ~/.tmux.conf` или **Ctrl+b** `r`.

Плагины Neovim: `:Lazy` / `:Lazy sync`.
