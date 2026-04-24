vim9script

# Простой аварийный Vim 9: без плагинов, тем, новых биндов и переноса строк.
set nocompatible
set encoding=utf-8
set fileencoding=utf-8

syntax enable
filetype plugin indent on

# Видимость и навигация.
set number
set relativenumber
set cursorline
set scrolloff=5
set sidescrolloff=5
set sidescroll=1
set nowrap

# Отступы: по умолчанию 4 пробела, для веб-форматов ниже будет 2.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

# Поиск без сюрпризов: регистр игнорируется, пока в запросе нет больших букв.
set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch

# Нормальное поведение редактора из коробки.
set backspace=indent,eol,start
set hidden
set history=1000
set mouse=a
set wildmenu
set wildmode=longest:full,full

# Без мусорных файлов рядом с редактируемым файлом.
set nobackup
set nowritebackup
set noswapfile

# Минимальный статус: файл, флаги, формат, тип, позиция.
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v]\ [%p%%]

# Не трогаем colorscheme: пусть Alacritty рисует как ему нравится.
set background=dark

augroup simple_vimrc
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType javascript,typescript,html,css,json,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
