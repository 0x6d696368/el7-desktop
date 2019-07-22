set history=700

set autoread

set tabstop=8
set wrap

set nolbr
set textwidth=80

set ignorecase

set nobackup
set nowb
"set noswapfile

"noremap <Up> <Nop>
"noremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>

set hlsearch

set lazyredraw

" no sound on errors
set noerrorbells
set novisualbell
set t_vb=
"set tm=500

syntax enable
setlocal spell spelllang=en_us,de_de

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

set background=dark
colorscheme ron
set textwidth=0
set formatoptions-=
set colorcolumn=81
hi ColorColumn ctermbg=8 
hi SpellBad ctermbg=1
hi SpellLocal ctermbg=17
"--------------------------------------------------------------------------------------------------------------

"ctags
set tags=./tags;


