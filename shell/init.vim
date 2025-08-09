
" Matty's neovim plugins
call plug#begin()

" General productivity plugins
Plug 'tpope/vim-sensible'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'editorconfig/editorconfig-vim'
Plug 'brooth/far.vim'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/vim-pencil'

" File navigation and fuzzy finding
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'

" Java development plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-dispatch'
Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'puremourning/vimspector'

call plug#end()