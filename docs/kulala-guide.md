# Kulala.nvim — HTTP-клиент в Neovim

Конфиг: [`nvim/lua/plugins/kulala.lua`](../nvim/lua/plugins/kulala.lua).  
Документация плагина: [neovim.getkulala.net](https://neovim.getkulala.net/docs/getting-started/install/).

Leader: **Пробел**. Префикс Kulala: **Space** `R` (заглавная R).

## Для чего

[Kulala.nvim](https://github.com/mistweaverco/kulala.nvim) — REST/HTTP/gRPC/WebSocket клиент прямо в редакторе. Работает с файлами `.http` и `.rest` (как в IntelliJ HTTP Client или REST Client в VS Code).

Когда использовать:

- быстро дернуть API без Postman/curl в терминале;
- хранить коллекцию запросов рядом с кодом проекта;
- прогонять цепочки запросов с переменными и окружениями.

## Установка

Плагин уже в lazy-spec. После обновления конфига:

```vim
:Lazy sync
```

При первом запуске Kulala сам скачает **kulala-core** (встроенный HTTP/gRPC/WS движок). Отдельный `curl` не нужен.

Расширения `.http` / `.rest` распознаются через `vim.filetype.add` в [`nvim/init.lua`](../nvim/init.lua).

### Опциональные утилиты

| Утилита | Зачем |
|---------|--------|
| `jq` | форматирование JSON в ответах |
| `xmllint` | форматирование XML/HTML |
| `prettier` / `prettierd` | форматирование HTML/JS/GraphQL в `.http` |

## Быстрый старт

1. Создай файл, например `api.http`.
2. Открой в nvim.
3. Поставь курсор на блок запроса (между `###`).
4. **Space** `Rs` или **Enter** — отправить запрос.
5. Ответ откроется в Kulala UI (сплит или float).

Минимальный пример:

```http
### Ping
GET https://httpbin.org/get
Accept: application/json

### Echo POST
POST https://httpbin.org/post
Content-Type: application/json

{
  "hello": "world"
}
```

## Клавиши (Space + R)

Глобальные keymaps включены (`global_keymaps = true`). В `.http` файлах доступен полный набор.

### Основное

| Клавиши | Действие |
|---------|----------|
| `Rs` | Отправить запрос под курсором |
| `Enter` | То же (только в `.http` / `.rest`) |
| `Ra` | Отправить все запросы в буфере |
| `Rr` | Повторить последний запрос |
| `Rf` | Найти запрос в буфере |
| `Ro` | Открыть Kulala UI вручную |
| `Rb` | Scratchpad (черновик запросов) |
| `C-c` | Прервать выполнение |

### В `.http` файле

| Клавиши | Действие |
|---------|----------|
| `Rn` / `Rp` | След./пред. запрос |
| `Rt` | Переключить headers/body |
| `Rc` | Скопировать как cURL |
| `RC` | Вставить из cURL |
| `Ri` | Inspect текущего запроса |
| `Re` | Выбрать environment |
| `Rj` | Cookies jar |
| `RS` | Статистика |
| `Rq` | Закрыть окно Kulala |

Подсказки: **Space** → `R` — which-key покажет маппинги.

### В окне ответа (Kulala UI)

| Клавиши | Действие |
|---------|----------|
| `H` / `B` / `A` | Headers / Body / All |
| `V` | Verbose |
| `S` | Stats |
| `[` / `]` | История ответов |
| `Enter` | Перейти к запросу в исходном буфере |
| `?` | Справка |
| `q` | Закрыть |

## Синтаксис `.http` (кратко)

| Элемент | Назначение |
|---------|------------|
| `###` | Разделитель между запросами |
| `### Имя запроса` | Именованный запрос (для `run`, ссылок) |
| `#` / `//` | Комментарий |
| `@name=value` | Переменная |
| `{{name}}` | Подстановка переменной |
| `# @prompt var Текст` | Запросить значение у пользователя |
| `import ./other.http` | Импорт запросов из файла |
| `run #Имя` | Выполнить именованный запрос |
| `< ./body.json` | Тело запроса из файла |
| `>> ./out.json` | Сохранить ответ в файл |

Переменные окружения: файл `http-client.env.json` или `.env` в проекте — см. [Using Environment Variables](https://neovim.getkulala.net/docs/usage/using-environment-variables/).

## LSP и автодополнение

Kulala поднимает встроенный LSP для `.http` файлов: автодополнение синтаксиса, переменных, hover (`K`), code actions (**Space** `ca`), форматирование (`gq` / **Space** `f`).

Отдельные kulala-LSP keymaps в конфиге не включены — используются стандартные LSP-биндинги nvim (см. [nvim-guide.md](./nvim-guide.md)).

## Типичный сценарий

1. В корне API-проекта: `api/requests.http`.
2. **Space** `ff` → открыть файл.
3. **Space** `Re` → выбрать `dev` / `prod` environment.
4. Курсор на нужный `###` блок → **Space** `Rs`.
5. Ответ слева/справа; **Enter** в UI — вернуться к запросу.
6. **Space** `Rc` — скопировать как cURL для CI/коллег.

```text
tmux pane: nvim
├── split: api.http        ← Space Rs
└── split: Kulala UI       ← H/B, [ ]
```

## Частые вопросы

| Вопрос | Ответ |
|--------|--------|
| Плагин не грузится | `:Lazy sync`, открой `.http` файл |
| Нет подсветки | Kulala тащит свой treesitter-парсер; при ABI mismatch — пересобрать парсер ([requirements](https://neovim.getkulala.net/docs/getting-started/requirements/)) |
| JSON «сырой» | Установи `jq` |
| Запросы из `.md` / `.ts` | Оберни в блок ` ```http ... ``` ` или выдели visual + **Space** `Rs` |
| Конфликт **Space** `e` | **Space** `e` — NvimTree; **Space** `Re` — environment Kulala (только в `.http`) |

## Полезные ссылки

- [Basic usage](https://neovim.getkulala.net/docs/usage/basic-usage/)
- [HTTP file spec](https://neovim.getkulala.net/docs/usage/http-file-specification/)
- [Variables & environments](https://neovim.getkulala.net/docs/usage/using-variables/)
- [Testing & asserts](https://neovim.getkulala.net/docs/usage/testing-and-reporting/)

См. также: [nvim-guide.md](./nvim-guide.md), [cheatsheet.md](./cheatsheet.md).
