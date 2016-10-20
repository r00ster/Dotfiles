" Vimrc file - Niel Roos

" Vundle settings
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'alvan/vim-closetag'
Plugin 'vim-scripts/Colour-Sampler-Pack'
Plugin 'Valloric/YouCompleteMe'
Plugin 'joshdick/onedark.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'Shutnik/jshint2.vim'
Plugin 'nrocco/vim-phplint'
Plugin 'majutsushi/tagbar'
Plugin 'tomtom/tcomment_vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tpope/vim-fugitive'
Plugin 'Shougo/vimproc'
Plugin 'Shougo/unite.vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" Settings
" Misc settings
set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set number          " show line numbers
set ignorecase      " ignore case when searching
set title           " show title in console title bar
set ttyfast         " smoother changes
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
set backspace=indent,eol,start " backspace past cindented spaces
set autoindent      " always set autoindenting on
set noexpandtab       " tabs are not converted to spaces
set fileformat=unix " allows for single line feeds at end of line

" Set ctags folder
set tags=tags;/

" Allow vim to copy to tmux
set clipboard=unnamed

" Turn off auto preview of GetDoc for YCM
set completeopt-=preview

" Speed up vim
set ttyfast         " faster redraw
set ttyscroll=3
set lazyredraw      " to avoid scrolling problems

" Set amount of lines to scroll by
noremap <C-u> 20<C-u>
noremap <C-d> 20<C-d>

" Syntax highlighing
syntax on
colorscheme onedark 
let g:onedark_termcolors=256
let g:airline_theme='onedark'

" Autocommand settings
if has("autocmd")
	" Restore cursor position
	au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

	" Filetypes (au = autocmd)
	au FileType helpfile set nonumber      " no line numbers when viewing help
	au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
	au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

" When using mutt, text width=72
	au FileType mail,tex set textwidth=72
	nnoremap ,p :set invpaste paste?<CR>
	set pastetoggle=,p
	set showmode
	au BufRead mutt*[0-9] set tw=72

" Set syntax for specific file formats
	au BufNewFile,BufRead  *.blade.* set ft=php.html
	au BufNewFile,BufRead  *.blade.* set syntax=blade.php
	au BufNewFile,BufRead  *.json.* set syntax=json
	au BufNewFile,BufRead  *jshintrc set syntax=json
endif

" Syntastic settings
" Use jshint (uses ~/.jshintrc)
let g:syntastic_javascript_checkers = ['jshint']

" Auto indent with curly braces
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O

" Keyboard mappings
" Misc
map <F1> :previous<CR>  " map F1 to open previous buffer
map <F2> :next<CR>      " map F2 to open next buffer
map <silent> <C-N> :silent noh<CR> " turn off highlighted search
map ,v :sp ~/.vimrc<cr> " edit my .vimrc file in a split
map ,e :e ~/.vimrc<cr>      " edit my .vimrc file
map ,u :source ~/.vimrc<cr> " update the system settings from my vimrc file
map ,tw :%s/\s\+$//<cr> " Remove trailing whitespace on all lines

" Control+P settings
set wildignore+=*/platform/*,*/superbalist-frontend/build/*,*/node_modules/*
let g:ctrlp_working_path_mode = 'ra'

" JsBeautify
map <c-f> :call JsBeautify()<cr>
  " or
  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  " for html
  autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  " for css or scss
  autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Write out html file
map ,h :source $VIM/vim70/syntax/2html.vim<cr>:w<cr>:clo<cr>

" Misc plugin mappings
nmap ,ne :NERDTreeToggle<cr>
nmap ,sr :SyntasticReset<cr>
nmap ,tb :TagbarToggle<cr>

" Keep copied text after paste
vnoremap p "_dP

" Keep visual mode after indenting
vnoremap > >gv
vnoremap < <gv

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
			\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
			\gvy/<C-R><C-R>=substitute(
			\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
			\gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
			\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
			\gvy?<C-R><C-R>=substitute(
			\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
			\gV:call setreg('"', old_reg, old_regtype)<CR>

" Create parent directories on save
augroup BWCCreateDir
	au!
	autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" Snipmate trigger
imap ,s <esc>a<Plug>snipMateNextOrTrigger
smap ,s <Plug>snipMateNextOrTrigger

" Search & replace (escape special characters)
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vmap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>//gc<left><left><left>
