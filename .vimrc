execute pathogen#infect()

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

let g:slime_target = "tmux"
set background=dark
let g:solarized_termcolors=256

:colorscheme wombat256mod


let g:neocomplcache_enable_at_startup = 1
set t_Co=256
set ruler
set number
set showmatch
set cursorline
set showcmd
set ttyfast
set relativenumber
set autochdir
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set colorcolumn=80

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
highlight OverLength ctermbg=235 ctermfg=DarkGray guibg=#FFD9D9
match OverLength /\%>80v.\+/

map <Left><Left> :split <cr> :e . <cr> <C-w>H<C-w> <cr>
map <Right><Right> :split <cr> :e . <cr> <C-w>L<C-w> <cr>
map <Up><Up>  :split <cr> :e . <cr> <C-w>K<C-w> <cr>
map <Down><Down>  :split <cr> :e . <cr> <C-w>J<C-w> <cr>

autocmd FileType clojure map <Esc><Esc> :w\|Require<cr>
autocmd FileType go map <Esc><Esc> :w\|! go build %<cr>

syntax on
filetype plugin indent on

set backupdir=/tmp
set directory=/tmp
