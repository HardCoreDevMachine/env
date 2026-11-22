# Agent Instructions

This project uses **bd** (beads) for issue tracking. Run `bd --sandbox prime` for full workflow context.

## Канонический Beads

- Все команды `bd` выполняйте с `--sandbox`: sandbox запрещает нежелательную автосинхронизацию и отправку данных.
- Не передавайте `--db`: подключение определяется версионируемым `.beads/config.yaml`.
- Все worktree используют общий `dolt sql-server` (`127.0.0.1:3308`, база `slicefsm`). Локальные данные и runtime-файлы находятся в `~/.beads/shared-server/` и `.beads/`, но не версионируются.
- Новые worktree создавайте через `bd --sandbox worktree create <path>`: Beads создаст redirect к общей конфигурации основного worktree.
- На новой машине установите совместимые `bd` и `dolt`, затем выполните `bd --sandbox bootstrap --yes`. Общий сервер запускается автоматически; параметры подключения и общий `project_id` уже находятся в версионируемых файлах `.beads/`.
- Версионируются `.beads/config.yaml` и `.beads/metadata.json`. Пароли задаются через `BEADS_DOLT_PASSWORD` или `~/.config/beads/credentials` и не добавляются в репозиторий.
- Рабочая спецификация адаптации SliceFSM-OMP: `docs/slicefsm-workflow-spec.md`.

## Quick Reference

```bash
bd ready              # Найти доступную работу
bd show <id>          # Прочитать задачу
bd update <id> --claim  # Атомарно взять задачу
bd close <id>         # Закрыть выполненную задачу
```

## Non-Interactive Shell Commands

**ALWAYS use non-interactive flags** with file operations to avoid hanging on confirmation prompts.

Shell commands like `cp`, `mv`, and `rm` may be aliased to include `-i` (interactive) mode on some systems, causing the agent to hang indefinitely waiting for y/n input.

**Use these forms instead:**
```bash
# Force overwrite without prompting
cp -f source dest           # NOT: cp source dest
mv -f source dest           # NOT: mv source dest
rm -f file                  # NOT: rm file

# For recursive operations
rm -rf directory            # NOT: rm -r directory
cp -rf source dest          # NOT: cp -r source dest
```

**Other commands that may prompt:**
- `scp` - use `-o BatchMode=yes` for non-interactive
- `ssh` - use `-o BatchMode=yes` to fail instead of prompting
- `apt-get` - use `-y` flag
- `brew` - use `HOMEBREW_NO_AUTO_UPDATE=1` env var

<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:ca08a54f -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

## Завершение сессии

1. Заведите Beads-задачи для оставшейся работы.
2. Выполните только относящиеся к изменению проверки.
3. Обновите статусы Beads.
4. Зафиксируйте изменённые файлы, проверки и риски в handoff.

Не выполняйте `git push` или `bd dolt push` без прямого запроса пользователя.
