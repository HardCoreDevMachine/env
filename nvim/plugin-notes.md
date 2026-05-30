# Neovim plugin notes

Общие гайды и шпаргалки: [docs/README.md](../docs/README.md) · [nvim-guide.md](../docs/nvim-guide.md) · [cheatsheet.md](../docs/cheatsheet.md).

Этот файл — заметки по плагинам, которые стоит держать только если они реально входят в ежедневный рабочий поток.

## tdd.nvim

Ссылка: https://github.com/zkucekovic/tdd.nvim

Для чего нужен: быстрый переход между PHP-классом и соответствующим PHPUnit-тестом. Плагин читает PSR-4 mapping из `composer.json`, смотрит `autoload` и `autoload-dev`, находит тест или предлагает создать skeleton.

Когда использовать:

- ты в PHP-классе и хочешь быстро открыть его тест;
- теста ещё нет, но структура проекта нормальная и описана через PSR-4;
- проект использует PHPUnit.

Команды:

```vim
:GetTest
:GetTestDebug
```

Практический сценарий:

1. Открываешь PHP-класс из `src/`.
2. Выполняешь `:GetTest`.
3. Если тест есть, открываешь его в split.
4. Если теста нет, соглашаешься на создание.
5. Если путь получился странный, запускаешь `:GetTestDebug` и проверяешь PSR-4 mapping.

Важно:

- после изменения `composer.json` запускай `composer dump-autoload -o`;
- плагин узкий и PHP-специфичный, поэтому держать его есть смысл только если часто работаешь с PHPUnit.

## dbout.nvim

Ссылка: https://github.com/zongben/dbout.nvim

Для чего нужен: подключение к SQLite/PostgreSQL/MySQL/MSSQL прямо из Neovim, запуск SQL-запросов и просмотр результатов в JSON.

Когда использовать:

- часто открываешь `.sql` файлы;
- хочешь быстро проверить запрос без отдельного GUI;
- тебе удобно держать DB-workflow внутри редактора.

Зависимости:

- Node.js;
- `sqls` в `PATH`, лучше через Mason;
- для самого плагина по документации нужен `build = "npm install"`.

Основные команды по документации:

```vim
:Dbout OpenConnection
:Dbout NewConnection
:Dbout DeleteConnection
:Dbout EditConnection
:Dbout AttachConnection
```

Внутри query buffer:

```text
F5  - выполнить запрос
F11 - форматировать SQL
F12 - открыть inspector
q   - закрыть viewer/inspector
```

Важно для текущего конфига:

- сейчас plugin-spec lazy-load'ится через `DBOutToggle` и `DBOutRun`;
- по документации основная команда называется `:Dbout`;
- если решишь реально пользоваться dbout, стоит привести lazy-spec к документации: `cmd = { "Dbout" }` и добавить `build = "npm install"`.

## deep-symbols

Ссылка: https://github.com/ahmedash95/deep-symbols

Для чего нужен: улучшенная навигация по символам PHP-класса, включая inherited members. Идея похожа на удобную структуру класса из PHPStorm.

Когда использовать:

- работаешь с большими PHP-классами;
- часто прыгаешь по методам;
- важны inherited methods/properties, а обычного LSP document symbols не хватает.

Зависимости:

- PHP;
- Composer;
- глобальный бинарь:

```sh
composer global require ahmedash95/deep-symbols
```

Проверь, что бинарь доступен:

```sh
deep-symbols
```

Команда в Neovim:

```vim
:lua require("deepsymbols").get_symbols()
```

Важно:

- плагин в первую очередь про PHP;
- без глобального composer binary он будет бесполезен;
- если используешь Telescope/LSP symbols и тебе хватает обычной навигации, можно не держать.

## Что добавить для тестов

### Универсально

Если хочется один UI для тестов в Neovim, смотри в сторону `nvim-neotest/neotest`. Это нормальная база для запуска тестов, просмотра результатов и перехода к ошибкам. Но это уже ещё один слой абстракции, поэтому добавлять стоит только если ты реально запускаешь тесты из редактора, а не из терминала.

Более простой вариант - `vim-test/vim-test`: меньше красиво, зато понятнее и часто достаточно.

### PHP

Рекомендации:

- `neotest` + адаптер для PHPUnit, если нужен UI тестов внутри Neovim;
- `vim-test`, если хочешь просто запускать nearest/file/suite без лишнего интерфейса;
- `tdd.nvim`, если часто прыгаешь между классом и тестом;
- `phpactor` или `intelephense` для навигации и refactor-like возможностей;
- `conform.nvim` оставить для `php-cs-fixer` / `phpcbf`.

Минимальный практичный набор для PHP:

```text
intelephense/psalm + conform + vim-test или neotest + tdd.nvim
```

### Go

Рекомендации:

- `gopls` через Mason/LSP;
- `gopher.nvim`, если используешь helper-команды для Go;
- `neotest` + Go adapter, если нужен test UI;
- `vim-test`, если достаточно запускать `go test` рядом с кодом;
- `dap-go`, если хочешь нормальный debug workflow поверх `delve`.

Минимальный практичный набор для Go:

```text
gopls + gofmt/goimports + vim-test или neotest + delve/dap-go
```

### JavaScript / TypeScript

Рекомендации:

- `tsserver` / `ts_ls` через LSP;
- `eslint` LSP или formatter/linter через project scripts;
- `prettier` через `conform.nvim`;
- `neotest-jest`, если проект на Jest;
- `neotest-vitest`, если проект на Vitest;
- Playwright adapter только если реально запускаешь e2e из Neovim.

Минимальный практичный набор для JS/TS:

```text
ts_ls + eslint + prettier/conform + neotest adapter под конкретный runner
```

## Мой критерий

Оставлять плагин стоит, если ты можешь назвать команду, которую запускаешь хотя бы раз в неделю. Если команда не вспоминается без подсказки, плагин лучше удалить или вынести в заметку на потом.
