" Enable syntax highlighting,
syntax on

" Enable file type plug,
filetype plugin on
filetype indent on

" Fast saving,
map qq :w!<cr>

" Toggle long lines highlighting,
map åå :call ShowLongLines()<cr>

" Toggle spaces/tabs highlighting,
map ÅÅ :call SeeTabs()<cr>

" Toggle spell checking,
map ää :setlocal spell!<cr>

" Never do sudo vim again,
cmap w!! w !sudo tee %

" Not really sure,
scriptencoding utf-8

" Set some reasonable defaults
set autoindent          " Simple indent
set cmdheight=2         " Height of the command bar
set cursorline          " highlight current line
set encoding=utf-8      " Show files in utf8
set expandtab           " Inserts <softtabstop-nr-of-spaces> instead of tabs
set fileencoding=utf-8  " Save files in utf8
set hls                 " Highlight matches
set hlsearch            " Highlight search results
set ic	                "	Ignore case while searching
set incsearch           " Search while typing
set laststatus=2        " Always show the status line
set lazyredraw          " Don't redraw while executing macros (good performance)
set linebreak           " Line break
set magic               " For regular expressions turn magic on
set mat=2               " How many 10ths of a second to blink when matching brackets
set number              " Always show number-row
set paste               " Always paste mode
set ruler               " Always show current position
set shiftwidth=4        " Number of spaces to use when indenting
set showmatch           " Show matching brackets when text indicator is over them
set smartcase           " When searching try to be smart about cases
set showcmd             " show command in bottom bar
set softtabstop=4       " Magic derp
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set tabpagemax=50       " Maximum number of tabs allowed open
set tabstop=4           " The amount of spaces a tab should be
set viminfo^=%          " Remember info about open buffers on close
set wrap                " Line break
set wildmenu            " visual auto complete for command menu
set backup
set backupdir=/tmp
set backupskip=/tmp/
set directory=/tmp
set writebackup

" Testing folding,
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <space> za

" Highlight pattern for tabs and dangling spaces,
:highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:match ExtraWhitespace /\s\+$\| \+\ze\t/

" Return to last edit position when opening files,
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Some magic,
augroup configgroup
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END

" Activate spell checking,
"setlocal spell!



"
" Functions
"

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Function to toggle high lightning on long lines,
function! ShowLongLines()
  if exists('w:long_line_match')
    silent! call matchdelete(w:long_line_match)
    unlet w:long_line_match
  elseif &textwidth > 0
    let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1)
  else
    let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1)
  endif
endfunc

" Function to toggle between showing tabs and dangling spaces,
function! SeeTabs()
  if !exists("g:SeeTabEnabled")
    let g:SeeTabEnabled = 1
    silent! match ExtraWhitespace /\s\+$\| \+\ze\t/
  else
    unlet g:SeeTabEnabled
    silent match ExtraWhitespace /uraynmyq/
  endif
endfunc

" Removes dangling spaces, called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction


" Call these at startup,
call ShowLongLines()
call SeeTabs()




