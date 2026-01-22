"""" General
set nocompatible            " Full-bodied VIM experience

" Disable modelines due to security concerns
set modelines=0
set nomodeline

set shell=zsh               " Make sure that sub-shells spawn zsh

syntax on                   " Syntax highlighting
filetype plugin indent on   " Automatically detect file type

if has('mouse')
    set mouse=a               " Enable mouse
    set mousehide             " Hide cursor while typing
endif

scriptencoding utf-8        " Default encoding

" Don't bother with swap- and backup-files
set noswapfile
set nobackup

if has('clipboard')
    set clipboard=unnamedplus   " Use system clipboard
endif

set autoindent                  " Automatically indent to the previous level
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent

set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set noeb vb t_vb=
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set rnu                         " Relative line numbers on
set lbr                         " Line break word boundary
set nowrap                      " Don't wrap lines
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=3                " Lines to scroll when cursor leaves screen
set scrolloff=2                 " Minimum lines to keep above and below cursor

highlight clear SignColumn  " SignColumn should match background
highlight clear LineNr      " Current line number row will have same background color in relative mode
let g:CSApprox_hook_post = ['hi clear SignColumn']
let mapleader=","

"""" Ctrl-P
"" Ignore files that are ignored in git/hg directories
let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': 'find %s -type f'
                \ }

nnoremap <leader>. :CtrlPTag<cr>

"""" Colors
set background=light
colorscheme selenized

"""" Autoformatter
"au BufWrite * :Autoformat
noremap <F3> :Autoformat<CR>
"let g:autoformat_verbosemode=1


"""" C
"au BufNewFile,BufRead *.ino set ft=cpp
let g:syntastic_c_checkers = ['clang-check']


"""" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"""" Arduino

"""" Javascript
"let g:syntastic_javascript_checkers = ['eslint']
"let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
"if matchstr(local_eslint, "^\/\\w") == ''
"    let local_eslint = getcwd() . "/" . local_eslint
"endif
"if executable(local_eslint)
"    let g:syntastic_javascript_eslint_exec = local_eslint
"endif


"""" Racket
"let g:syntastic_enable_racket_racket_checker = 1
"let g:syntastic_racket_checkers = ["code-ayatollah"]
"au BufReadPost *.rkt,*.rktl,*.scrbl set filetype=racket
"au filetype racket set lisp
"au filetype racket set autoindent
"autocmd filetype lisp,scheme,racket setlocal equalprg=scmindent.rkt
"let g:formatdef_racket = '"scmindent.rkt"'
"let g:formatters_racket = ['racket']
"let g:rainbow_active = 1
"let g:sexp_enable_insert_mode_mappings = 1
"let g:sexp_insert_after_wrap = 0
"let g:rainbow_guifgs = ['blue', 'darkgreen', 'orange', 'red', 'darkmagenta']
"let g:rainbow_ctermfgs = ['blue', 'darkgreen', 'darkyellow', 'red', 'darkmagenta']


"""" Prettier
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

"""" Lisp
let g:slimv_swank_cmd = '! tmux new -d -n REPL-SBCL "sbcl --load /home/jzp/quicklisp/dists/quicklisp/software/slime-v2.30/start-swank.lisp"'
"let g:slimv_swank_cmd = '! xterm -e sbcl --load /home/jzp/quicklisp/dists/quicklisp/software/slime-v2.30/start-swank.lisp &'
let g:slimv_lisp = 'sbcl'
let g:slimv_impl = 'sbcl'
let g:lisp_rainbow = 1


"""" GameBoy Assembly
au BufRead,BufNewFile *.ds set filetype=rgbds
autocmd filetype rgbds nnoremap <F5> :w<CR> :make<CR>

"""" ca65 Assembly
au BufNewFile,BufRead *.asm,*.inc set ft=asm_ca65

""" Zig LSP stuff

if executable('zls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'zls',
        \ 'cmd': {server_info->['zls']},
        \ 'allowlist': ['zig'],
        \ })
endif

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
