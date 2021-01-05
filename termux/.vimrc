" leader means \
"
" F2       toggle filemenu
" F5       run this file's code
" F6       auto format
" F8       plugin install
" \t       goto definition
" ctrl+c   toggle check whitespace
" ctrl+a+c chose all and copy
" ctrl+p   close current tab
" ctrl+x   change to next buffer
" ctrl+s   close and save current buffer
" space    fold code
" """"""""""""""""""""""""""""""""

set mouse=a
set enc=utf8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set nu
set fencs=utf8,gbk,gb2312,gb18030
set cursorline
set nocompatible
filetype plugin indent on
set ic
set hlsearch
set incsearch
set autoindent
set smartindent
set scrolloff=4
set showmatch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nobackup
set noswapfile
set autoread
set clipboard=unnamed
set ruler
set confirm
set wildmenu
set linespace=0
set numberwidth=3

" tab&buffer control
noremap <C-P> :tabc[lose]<CR>
noremap <C-X> :bn<CR>
noremap <C-S> :bp<bar>sp<bar>bn<bar>bd<CR>

" show white spaces
noremap <C-C> :set list!<CR>
set listchars=tab:--,trail:~,extends:>,precedes:<
set listchars+=space:‧
set listchars+=eol:$

" ctrl+a+c effect
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G

" autocomplete ' (
inoremap ( ()<ESC>i
inoremap ' ''<Esc>i

" window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" pythonsets
let python_highlight_all=1
au Filetype python set expandtab
au Filetype python set fileformat=unix
au Filetype python set foldmethod=indent
au Filetype pythin set foldlevel=99
autocmd Filetype python set foldmethod=indent
noremap <space> za
autocmd Filetype python set foldlevel=99

" auto run by volume up+5
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    exec "!clear"
    exec "!time python %"
  elseif &filetype == 'go'
    " exec !go build %<
    exec "!time go run %"
  endif
endfunc

" vundle sets
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
set completeopt-=preview
set completeopt=longest,menu
let g:ycm_complete_in_comments=1
let g:ycm_error_symbol='>✘'
let g:ycm_warning_symbol='>!'
let g:ycm_min_num_identifier_candidate_chars=2
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_complete_in_strings=1
let g:ycm_filetype_whitelist={
			\ "c":1,
			\ "cpp":1,
			\ "markdown":1,
			\ "objc":1,
			\ "python":1,
			\ "go":1,
			\ "sh":1,
			\ "zsh":1,}
noremap <C-Z> <NOP>
let g:ycm_semantic_tiggers={
			\ 'c,cpp,python,go,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
map <leader>t :YcmCompleter GoToDefinitionElseDeclaration<CR>
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
	let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif

Plugin 'Chiel92/vim-autoformat'
nnoremap <F6> :Autoformat<CR>
let g:autoformat_autoindent=0
let g:autoformat_retab=0
let g:autoformat_remove_trailing_spaces=0

" Plugin 'sillybun/autoformatpythonstatement'
" autocmd Filetype python let g:autoformatpython_enabled=1

Plugin 'jnurmine/Zenburn'
let g:zenburn_enable_TagHighlight=1

Plugin 'w0rp/ale'
let g:ale_fix_on_save=1
let g:ale_completion_enabled=1
let g:ale_sign_column_always=1
let g:airline#extensions#ale#enabled=1

Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
if !exists("g:airline_symbols")
	let g:airline_symbols={}
endif
let g:airline_powerline_fonts=1
let g:airline_left_sep="»"
let g:airline_left_alt_sep="❯"
let g:airline_right_sep="«"
let g:airline_right_alt_sep="❮"
let g:airline_symbols.linenr="¶"
let g:airline_symbols.branch="Ψ"
let g:airline_symbols.readonly="🔒"

Plugin 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>
autocmd bufenter * if( winnr("$")==1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * NERDTree
let NERDTreeWinSize=25

call vundle#end()
filetype plugin indent on
map <F8> :PluginInstall<CR>

" File title
autocmd BufNewFile *.sh,*.py,*.md,*.cpp exec ":call SetTitle()"
func! SetTitle()
	call setline(1, "#FileName: ".expand("%"))
	call append(line("."), "#CreateTime: ".strftime("%c"))
	if &filetype == 'sh'
		call append(line(".")+1, "#!/bin/zsh")
		call append(line(".")+2, "")
	endif
	autocmd BufNewFile * normal G
endfunc

colors zenburn


" python virtualenv support # useless
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"	project_base_dir = os.environ['VIRTUAL_ENV']
"	active_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"	execfile(active_this, dict(__file__=active_this))
"EOF
