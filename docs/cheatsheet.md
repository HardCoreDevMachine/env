# Шпаргалка: tmux + Neovim + Ranger

Краткая версия. Подробности: [tmux-guide.md](./tmux-guide.md), [nvim-guide.md](./nvim-guide.md), [ranger-guide.md](./ranger-guide.md).

---

## Модель за 10 секунд

| | tmux | Neovim | Ranger |
|---|------|--------|--------|
| **Вкладка** | Window (`#1·name` внизу) | Buffer (bufferline сверху) | Tab (`C-n`, `gt`) |
| **Панель** | Pane | Split (`:vsp`, `:sp`) | 3 колонки (parent / cwd / preview) |
| **Ходить без префикса** | `C-h` `C-j` `C-k` `C-l` `C-\` | те же (navigator) | `h` `j` `k` `l` |
| **Fuzzy find** | — | `Space` `ff` (Telescope) | `C-f` / `gf` (fzf) |
| **Префикс tmux** | `C-b` | — | — |

Navigator **не создаёт** окна/панели — только **переключает фокус**.

---

## tmux

### Префикс `C-b` (= Ctrl+b)

| | | |
|---|---|---|
| **Окна (вкладки)** | | **Панели** |
| `c` новое окно | | `\|` split │ |
| `n` / `p` след/пред | | `-` split ─ |
| `0-9` по номеру | | `x` закрыть |
| `w` список | | `z` zoom |
| `,` имя | | |
| `&` закрыть окно | | |
| `d` detach | | |
| `r` reload config | | |

### Без префикса (navigator)

| `C-h` | `C-j` | `C-k` | `C-l` | `C-\` |
|-------|-------|-------|-------|-------|
| ← | ↓ | ↑ | → | pred. pane |

### Сессии (shell)

```bash
tmux new -s work    # новая
tmux ls             # список
tmux attach -t work # войти
```

---

## Neovim

**Leader = Space**

### Файлы и UI

| | | | |
|---|---|---|---|
| `ff` | find file | `e` | tree |
| `fg` | grep | `ef` | tree → file |
| `fb` | buffers | `tt` | terminal |
| | | `gg` | LazyGit |

### Сплиты

| | |
|---|---|
| `:vsp` | вертикально |
| `:sp` | горизонтально |
| `C-hjkl` | между split / tmux |

### LSP

| | | | |
|---|---|---|---|
| `gd` | definition | `K` | hover |
| `gr` | references | `[d` `]d` | diagnostics |
| `Space` `rn` | rename | `Space` `ca` | action |
| `Space` `f` | format | `Space` `xx` | trouble |

### Git

| | |
|---|---|
| `]h` `[h` | hunk |
| `Space` `hs` `hr` `hp` | stage / reset / preview |

### Insert (cmp)

| `Tab` / `S-Tab` | `C-Space` | `CR` | `C-e` |
|-----------------|-----------|------|-------|
| меню / snippet | открыть | confirm | abort |

### Команды

```
:Lazy          :Mason         :TmuxNavigatorProcessList
:bnext :bp     :bd             :GetTest   (PHP tdd.nvim)
```

---

## Ranger

Конфиг: `config/ranger/`. Запуск: `ranger`.

### Навигация

| `h` | `j` | `k` | `l` | `zh` |
|-----|-----|-----|-----|------|
| parent | ↓ | ↑ | open | hidden |

### fzf и кастом

| `C-f` / `gf` | `2`+`C-f` | `gh` | `uu` | `yp` |
|--------------|-----------|------|------|------|
| fuzzy find | dirs only | ~ | cd .. | yank path |

### Файлы

| | | | |
|---|---|---|---|
| `Space` | mark | `yy` / `dd` | yank / cut |
| `pp` | paste | `cw` | rename |
| `dD` | delete | `Enter` | open (nvim) |

### Вкладки

| `C-n` | `gt` / `gT` | `m`+`'` | `Q` |
|-------|-------------|---------|-----|
| new tab | next/prev | bookmark | quit |

---

## Один workflow

```text
1. tmux new -s work
2. C-b c          → второе окно (логи)
3. C-b |          → nvim | shell
4. shell: ranger  → C-f найти файл → Enter (nvim)
5. nvim → Space ff, :vsp
6. C-l            → в shell pane
7. C-b n          → другое tmux-окно
```

---

## Путаницы

| Вопрос | Ответ |
|--------|--------|
| Navigator = вкладки? | Нет, только фокус |
| tmux вкладки | `C-b` `c` `n` `p` |
| nvim вкладки | buffers, `Space` `fb` |
| `C-\` | prev pane (не ToggleTerm) |
| `C-l` в nvim+tmux | навигация, не clear |
| `C-f` в ranger | fzf, не «find» в shell |
| ranger vs nvim tree | ranger — ФС в терминале; `Space e` — дерево в nvim |

---

## ASCII-схема

```text
Session
├── Window 0 ............... C-b n/p, C-b 0-9
│   ├── Pane: nvim ......... C-hjkl, Space ff
│   │   ├── split A
│   │   └── split B
│   └── Pane: shell ........ C-l из nvim
└── Window 1 (logs) ......... C-b c
```
