call plug#begin()
Plug 'kana/vim-textobj-user'
Plug 'isovector/ghci.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'deris/vim-shot-f'
Plug 'ap/vim-buftabline'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/vim-lamdify'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'rhysd/conflict-marker.vim'
Plug 'justinmk/vim-sneak'
Plug 'Chiel92/vim-autoformat'

" Syntastic
Plug 'vim-syntastic/syntastic'

" Clippy check
Plug 'wagnerf42/vim-clippy'

" colors
Plug 'altercation/vim-colors-solarized'
Plug 'ptrr/phd-vim'
Plug 'ciaranm/inkpot'
Plug 'ajh17/Spacegray.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'ronny/birds-of-paradise.vim'
Plug 'ratazzi/blackboard.vim'
Plug 'justincampbell/vim-railscasts'
Plug 'vim-scripts/leo256'
Plug 'w0ng/vim-hybrid'
Plug 'ap/vim-css-color'
Plug 'Valloric/vim-valloric-colorscheme'
Plug 'lanox/lanox-vim-theme'
Plug 'pkukulak/idle'
Plug 'mhartington/oceanic-next'
Plug 'geetarista/ego.vim'
Plug 'monkoose/boa.vim'
Plug 'euclio/vim-nocturne'
call plug#end()

" Things we can align on
let g:easy_align_delimiters = {
\ '[': { 'pattern': '[[\]]', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ '(': { 'pattern': '[()]', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ ']': { 'pattern': '[[\]]', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ ')': { 'pattern': '[()]', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ '<': { 'pattern': '[<]', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ '.': { 'pattern': '\.', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '>': { 'pattern': '[->]', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ ':': { 'pattern': '::', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '$': { 'pattern': '\$', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '~': { 'pattern': '\.\~', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '#': { 'pattern': '#', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ 'q': { 'pattern': '\(qualified\)\?\ze ', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ 'c': { 'pattern': '.\zs--', 'left_margin': 2, 'right_margin': 1, 'stick_to_left': 0, 'ignore_groups': [] },
\ }


function! PasteOver(type, ...)
    let saveSel = &selection
    let &selection = "inclusive"
    let saveReg = @@
    let reg = v:register
    let regContents = getreg(reg)

    if a:0  " Invoked from Visual mode, use '< and '> marks.
        silent exe "normal! `<" . a:type . "`>"
    elseif a:type == 'line'
        silent exe "normal! '[V']"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]"
    else
        silent exe "normal! `[v`]"
    endif

    execute "normal! \"" . reg . "p"

    let &selection = saveSel
    let @@ = saveReg

    call setreg(reg, regContents)
endfunction

function! SetPasteOver()
    set opfunc=PasteOver
    return "g@"
endfunction

nnoremap <expr> PP SetPasteOver()


" Allow switching to buffer #<n> by typing <n>e
function! s:bufSwitch(count)
    if count >=# 1
        return ":\<C-U>" . count . "b\<CR>"
    endif
    return 'e'
endfunction
nnoremap <expr> e <SID>bufSwitch(v:count)

function! AddHsPragma()
    " Add a new HS pragma, and sort the list so it's pretty
    let pragma = input("LANGUAGE ")
    normal! ms
    if match(getline(1), "module") == 0
      execute "normal! ggO\<ESC>"
    endif
    if pragma != ""
        execute "normal! ggO{-# LANGUAGE " . pragma . " #-}\<ESC>"
    endif
    execute "normal! ggvip:sort\<CR>gv:EasyAlign -#\<CR>"
    normal `s
endfunction

nnoremap :: :bp\|bd #<CR>
nnoremap <C-q> <C-W><C-q>
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap K :silent! grep! <cword><CR>:copen<CR>
nnoremap <silent> <leader>si magg/^import<CR>vip:EasyAlign q<CR>gv:sort /.*\%18v/<CR>:noh<CR>`a
nnoremap # :e #<CR>
nnoremap <silent> <leader>st :! (cd `git rev-parse --show-toplevel`; hasktags **/*.hs)<CR>:set tags=<C-R>=system("git rev-parse --show-toplevel")<CR><BS>/tags<CR>
nnoremap  <leader>l :call AddHsPragma()<CR>
nnoremap ;; :w<CR>
vmap <leader><space> <Plug>(EasyAlign)

let g:grep_cmd_opts = '--line-numbers --noheading'
let mapleader = " "
let g:buftabline_numbers = 1

augroup automaticallySourceVimrc
  au!
  au bufwritepost .vimrc source ~/.vimrc
augroup END

nnoremap <leader>ev :e ~/.vimrc<cr>

set number
set relativenumber
set guitablabel=%-0.12t%M
set showtabline=2
set nocompatible
set grepprg=ag\ --nogroup\ --nocolor
set bg=dark
colo phd
set incsearch
set hlsearch
set expandtab

"CTags USAGE:
" :tag<followed by one of thing>
" :stag -- same as above and splits window
" :ts<followed by multiple named thing>
" :sts -- same as above and splits window
"
nnoremap <leader>h :!hasktags -o tags -c --ignore-close-implementation . && /usr/local/bin/ctags --append=yes .<CR><CR>

nnoremap <leader>sv :vert sb  <BS>

nnoremap Y y$
nnoremap <Leader>s *N:noh<CR>:%s//

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap L <C-W><C-L>
nnoremap H <C-W><C-H>

nnoremap <silent> <C-c> :copen<CR>

"Remove all trailing whitespace by pressing F5
nnoremap <leader>rw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

inoremap -= <space>-><space>
inoremap =- <space><-<space>

syntax on
filetype plugin indent on

let g:haskell_indent_do = 3
let g:haskell_indent_if = 3
let g:haskell_indent_in = 1
let g:haskell_indent_let = 4
let g:haskell_indent_case = 2
let g:haskell_indent_where = 6

set softtabstop=2
set tabstop=2
set shiftwidth=2

" Show trailing whitespace:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" stylish-haskell on save
autocmd BufWrite *.hs :Autoformat
" Don't automatically indent on save, since vim's autoindent for haskell is buggy
autocmd FileType haskell let b:autoformat_autoindent=0

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_rust_checkers = ['clippy']
