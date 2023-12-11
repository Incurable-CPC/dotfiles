source /etc/vimrc

set nu
set cindent
set tabstop=4
set shiftwidth=4
set nowrap
set expandtab
set laststatus=2

" set Vim-specific sequences for RGB colors
" set term=screen-256color
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set t_Co=256
" set termguicolors

let mapleader=' '

set ignorecase
set incsearch
set smartcase

nnoremap j jzz
nnoremap k kzz
nnoremap n nzz
nnoremap N Nzz
nnoremap % %zz
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

cnoremap <C-N> <down>
cnoremap <C-P> <up>

function! s:switchwin(key)
    exec "set <M-".a:key.">=".a:key
    exec "nnoremap <M-".a:key."> <C-W>".a:key
    exec "inoremap <M-".a:key."> <Esc><C-W>".a:key
endfunc

for ch in ['h', 'j', 'k', 'l']
    call s:switchwin(ch)
endfor

function! s:jumptab(idx)
    exec "set <M-".a:idx.">=".a:idx
    exec "nnoremap <M-".a:idx."> ".a:idx."gt"
    exec "inoremap <M-".a:idx."> <Esc>".a:idx."gt"
endfunc

for i in range(9)
    call s:jumptab(nr2char(char2nr(i) + 1))
endfor

set timeout timeoutlen=1000
set ttimeout ttimeoutlen=80

set tags=./tags;/
set hi=1000

call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'uarun/vim-protobuf'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'romainl/vim-qf'
Plug 'ervandew/supertab'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Plug 'jeaye/color_coded'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --go-completer' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'charlespascoe/vim-go-syntax'
call plug#end()


" au BufNewFile,BufRead *.c set filetype=cpp
" execute pathogen#infect()
filetype plugin indent on
au BufNewFile,BufRead *.mxdr set filetype=mxdr
au BufNewFile,BufRead *.mxdr.tpl set filetype=mxdr_tpl

" Solarized
syntax on
set background=dark
let g:solarized_termtrans=1
" let g:solarized_termcolors=256
colorscheme solarized
hi LineNr ctermfg=darkcyan
hi Method ctermfg=lightblue
hi Member ctermfg=magenta
hi PreProc ctermfg=darkmagenta
hi Special ctermfg=red

set exrc
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=gbk,utf-8
set hlsearch
set ffs=unix,dos

set backspace=indent,eol,start

set nocsverb
cs add cscope.out
set csverb

" function! CscopeBuildCB(channel)
"     cs reset
" endfunction
" 
" function! CscopeBuild()
"     call system('find . | egrep "\.(c|h|cc|cpp)$" > cscope.files')
"     call job_start('cscope -bq', {
"                 \ 'close_cb': 'CscopeBuildCB'
"                 \ })
" endfunction
" 
" noremap <F5> :call CscopeBuild()<CR>
" 
" nnoremap <C-]> :cscope find g  <C-R>=expand('<cword>')<CR><CR>
" nnoremap <buffer> <leader>cs :cscope find s  <C-R>=expand('<cword>')<CR><CR>
" nnoremap <buffer> <leader>cg :cscope find g  <C-R>=expand('<cword>')<CR><CR>
" nnoremap <buffer> <leader>cc :cscope find c  <C-R>=expand('<cword>')<CR><CR>
" nnoremap <buffer> <leader>ct :cscope find t  <C-R>=expand('<cword>')<CR><CR>
" nnoremap <buffer> <leader>ce :cscope find e  <C-R>=expand('<cword>')<CR><CR>
" nnoremap <buffer> <leader>cf :cscope find f  <C-R>=expand('<cfile>')<CR><CR>
" nnoremap <buffer> <leader>ci :cscope find i ^<C-R>=expand('<cfile>')<CR>$<CR>
" nnoremap <buffer> <leader>cd :cscope find d  <C-R>=expand('<cword>')<CR><CR>

nnoremap <leader>k :e %:r.cc<CR>
nnoremap <leader>j :e %:r.h<CR>

nnoremap <C-L> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-L>


" LeaderF
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_ShowDevIcons = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_CommandMap = {
            \ '<C-X>': ['<C-S>'],
            \ '<C-]>': ['<C-V>'],
            \ '<C-U>': ['<C-L>'],
            \ }
let g:Lf_WildIgnore = {
            \ 'dir': ['build'],
            \ 'file': ['*.o', '*.d', '*.gch',
            \          '*.pb.h', '*.pb.cc', '*.pb.go',
            \          '*.pb.gen.cc', '*.pb.gen.go'],
            \ }

set <M-p>=p
nnoremap <M-p> :LeaderfFunction<CR>
inoremap <M-p> <ESC>:LeaderfFunction<CR>


" NerdTree
let NERDTreeIgnore = ['\.d$', '\.o$', '^mxdb_.*\.h$']
let NERDTreeIgnore += ['\.pb\.h$', '\.pb\.cc$', '\.pb\.go$']
let NERDTreeIgnore += ['\.pb\.gen\.cc$', '\.pb\.gen\.go$' ]
noremap <C-N> :NERDTreeFind<CR>
noremap <C-X> :NERDTreeClose<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" color_coded
let g:color_coded_enabled = 0

" go syntax
let g:go_highlight_braces = 0
let g:go_highlight_brackets = 0
let g:go_highlight_parens = 0

" YouCompleteMe
" let g:ycm_show_diagnostics_ui = 0
let g:ycm_clangd_binary_path = '/usr/bin/clangd'
let g:ycm_auto_hover = ''
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_log_level = 'info'
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings = 1
let g:ycm_clangd_args=['--header-insertion=never']
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }

" let g:ycm_add_preview_to_completeopt = 0
" set completeopt=menu,menuone
noremap <C-K> :YcmCompleter GoTo<CR>
let g:ycm_key_list_select_completion = ['<C-N>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-P>', '<Up>']

let g:ycm_enable_semantic_highlighting = 1
let MY_YCM_HIGHLIGHT_GROUP = {
            \   'typeParameter': 'PreProc',
            \   'parameter': 'Normal',
            \   'variable': 'Normal',
            \   'property': 'Member',
            \   'enumMember': 'Constant',
            \   'event': 'Special',
            \   'member': 'Member',
            \   'method': 'Method',
            \   'class': 'Special',
            \   'namespace': 'Special',
            \ }

for tokenType in keys( MY_YCM_HIGHLIGHT_GROUP )
    call prop_type_add( 'YCM_HL_' . tokenType,
                \ { 'highlight': MY_YCM_HIGHLIGHT_GROUP[ tokenType ] } )
endfor

func s:CustomShowDiagnostics()
    if (youcompleteme#GetErrorCount() == 0)
        lclose
    endif
    YcmDiags
endfunc
command! CustomYcmDiags call s:CustomShowDiagnostics()
noremap <F3> ::YcmRestartServer<CR>
noremap <F4> :CustomYcmDiags<CR>

" echodoc.vim
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'popup'
" highlight link EchoDocPopup Pmenu

let g:SuperTabDefaultCompletionType = '<C-N>'
let g:qf_loclist_window_bottom = 0

" let g:UltiSnipsExpandTrigger = '<Tab>'
" let g:UltiSnipsJumpForwardTrigger = '<Enter>'
" let g:UltiSnipsJumpBackwardTrigger = '<S-Enter>'


"  Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' .  i .  'T'
            let s .= (i == t ?  '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$') 

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ?  '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' .  file .  ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ?  '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif


let g:clang_format_enable = 1
function! FormatOnSave()
    if !empty(findfile('.clang-format', ';')) && filereadable(expand('%'))
        if g:clang_format_enable
            let l:formatdiff = 1
            " let l:line = 'all'
            py3f /usr/share/clang/clang-format.py
        endif
    endif
endfunction
autocmd BufWritePre *.h,*.c,*.cc,*.cpp call FormatOnSave()

