" Joshua Reed's .vimrc
" Spring  2017
"
" This is symbolically linked to my home folder.

set foldmethod=indent
let foldnestmax=1

" Enables filetype detection, and 
" filetype specific plugin selection.
filetype plugin on

" Pathogen manages other plugins.
execute pathogen#infect()

" Set Ultisnips trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Turn syntax highlighting on.
syntax on

" Set syntax for filetypes.
augroup SetFiletypes
 au BufRead,BufNewFile *.cir   set filetype=spice
 au BufRead,BufNewFile *.spi   set filetype=spice
 au BufRead,BufNewFile *.tex   set filetype=tex
 au BufRead,BufNewFile *.cls   set filetype=tex
augroup END

" Source .vimrc or .vim files.
au FileType vim nnoremap <leader>s :source %<cr>

" Set latex compile hotkey.
augroup LatexCommands
  au!               
  au FileType tex nnoremap <leader>c :!latexmk -pdf -xelatex <cr><cr>
  au FileType tex nnoremap <leader>v :!exec evince %<.pdf &<cr>
augroup END

" Disable error bells.
set noerrorbells visualbell t_vb=
au! GUIEnter * set visualbell t_vb=

" Set search to case insensitive.
" To search case sensitive put \C anywhere in the search clause.
set ignorecase

" Set color scheme 
" colorscheme molokai
" set t_Co=256

" Turn on line numbers.
set number

" Make tabs = 4 spaces.
set tabstop=4 shiftwidth=4 expandtab shiftround

" Make backspace work normally
set backspace=indent,eol,start

" Remove gvim toolbar, menubar, and scrollbar.
set guioptions-=m "menubar
set guioptions-=T "toolbar
set guioptions-=r "right scrollbar

" Make gui right clickable.
set mousemodel=popup

" Set a color column to demarkate 72 column width for python files
" This is only available in vim >= 7.3.
au FileType python set cc=79

" Don't use a swap file
set noswapfile

" Pipes out visual selection to command line
vnoremap <leader>q y:echom system("./test.tcl", shellescape(<C-r>"))


" Change buffer -- normal mode
nnoremap <leader>n :w <bar> bnext<CR>
nnoremap <leader>b :w <bar> bprevious<CR>

" Capitalize current word -- insert mode
inoremap <C-u> <esc>viwUi

" Automatically read file on update
set autoread

" Reload file
nnoremap  <leader>e :edit<CR>

" ctr-c copy -- visual mode only
vnoremap <C-c> "+y

" ctr-v paste -- visual and insert modes
inoremap <C-v> <Esc>"+gPa
vnoremap <C-v> "+gP


" Run current file
augroup RunThis
  au!
                          nnoremap <leader>r : ! %:p <CR>
  au filetype python nnoremap <leader>r :w <bar> exec '!python '.shellescape('%')<CR>
  au filetype c      nnoremap <leader>r :w <bar> exec '!gcc '.shellescape('%').' 
\                                        -o '.shellescape('%:r').' 
\                                        && ./'.shellescape('%:r')<CR>
  au filetype cpp    nnoremap <leader>r :w <bar> exec '!g++ '.shellescape('%').' 
\                                             -o '.shellescape('%:r').' 
\                                             && ./'.shellescape('%:r')<CR>
augroup END


" Remember upon exit.
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  Will save up to 100 lines for each register
"  :20  :  Up to 20 lines of command-line history will be remembered
"  %    :  Saves and restores the buffer list
"  n... :  Where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.vim/viminfo


" Restore cursor position on re-open
function! ResCur()
  if line("'\"") <= line("$") 
    normal! g`" 
  endif
endfunction

au! BufWinEnter * call ResCur()

