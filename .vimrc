call plug#begin()
" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'machakann/vim-highlightedyank'

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

" Clippy check
Plug 'alx741/vim-rustfmt'

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

" fuzzy search
Plug 'airblade/vim-rooter' " does a relative search in the nearest git directory root
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder
Plug 'junegunn/fzf.vim' " also fuzzy finder

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Unison
Plug 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }

" Svelte
Plug 'leafOfTree/vim-svelte-plugin'

call plug#end()

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" =============================
" Coc Settings
" =============================
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffer<CR>

function! Haskell_add_language_pragma()
  let line = max([0, search('^{-# LANGUAGE', 'n') - 1])
  :call fzf#run({
  \ 'source': 'ghc --supported-languages',
  \ 'sink': {lp -> append(line, "{-# LANGUAGE " . lp . " #-}")},
  \ 'options': '--multi --ansi --reverse --prompt "LANGUAGE> "',
  \ 'down': '25%'})
  execute "normal! ggvip:sort\<CR>gv:EasyAlign -#\<CR>"
endfunction

nnoremap :: :bp\|bd #<CR>
nnoremap <C-q> <C-W><C-q>
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap # :e #<CR>
nnoremap ;; :w<CR>

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

set softtabstop=4
set tabstop=4
set shiftwidth=4

" Show trailing whitespace:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" stylish-haskell on save
" autocmd BufWrite *.hs :Autoformat
" Don't automatically indent on save, since vim's autoindent for haskell is buggy
" autocmd FileType haskell let b:autoformat_autoindent=0

" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
  set grepprg=rg\ --vimgrep
endif
