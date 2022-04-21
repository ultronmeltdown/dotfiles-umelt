" Basic Settings {{{

set nocompatible
filetype plugin on
filetype plugin indent on
syntax on
set relativenumber
set title
set clipboard+=unnamedplus
set noshowmode
set laststatus=0
set showcmd
set ignorecase
set wildignorecase
set foldmethod=manual
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set nohlsearch
set incsearch
let mapleader = ","
let maplocalleader = "\\"
colorscheme darkblue

" }}}

" Mapping {{{

nnoremap <leader>h :if &hlsearch<cr> set nohlsearch<cr> else<cr> set hlsearch<cr> endif<cr><cr>
nnoremap c "_c
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap ,html :-1read $XDG_CONFIG_HOME/nvim/template/.skeleton.html<CR>3jwf>a
nnoremap <leader>w :match Error /\v\s+/<cr>
nnoremap <leader>W :match none<cr>
nnoremap qq :quit!<cr>
nnoremap qw :wq<cr>

" }}}

" Abbreviations {{{

iabbrev myname ultronmeltdown
iabbrev mymail ultronmeltdown@gmail.com
iabbrev mysig -- <cr>UltronMeltdown<cr>ultronmeltdown@gmail.com

" }}}

" Plugin listing {{{

call plug#begin('~/.local/share/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-pathogen'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'preservim/vim-lexical'
Plug 'preservim/vim-litecorrect'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-textobj-quote'
Plug 'preservim/vim-textobj-sentence'
Plug 'jamis/fuzzyfinder_textmate'
Plug 'spiiph/vim-space'
Plug 'rcarriga/nvim-notify'
Plug 'mileszs/ack.vim'
Plug 'skalnik/vim-vroom'
Plug 'christoomey/vim-sort-motion'
Plug 'chaoren/vim-wordmotion'
Plug 'dense-analysis/ale'
""Plug 'eluum/vim-autopair'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'uiiaoo/java-syntax.vim'
Plug 'luochen1990/rainbow'
Plug 'vim-syntastic/syntastic'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tomtom/tlib_vim'
Plug 'mbbill/undotree'
Plug 'vifm/vifm.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'voldikss/vim-floaterm'
Plug 'dbmrq/vim-ditto', { 'do': ':DittoOff' }
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'sirtaj/vim-openscad'
Plug 'sheerun/vim-polyglot'
Plug 'glts/vim-radical'
Plug 'psliwka/vim-smoothie'
Plug 'wesQ3/vim-windowswap'
Plug 'vimwiki/vimwiki'
Plug 'inkarkat/vim-visualrepeat'
Plug 'inkarkat/vim-ingo-library'
Plug 'terryma/vim-multiple-cursors'
Plug 'sirtaj/vim-openscad'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'kristijanhusak/vim-simple-notifications'
Plug 'christoomey/vim-titlecase'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'christoomey/vim-system-copy'
Plug 'dstein64/vim-menu'
call plug#end()

" }}}

" Plugin Options {{{

" vim-pencil
  augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
"  autocmd FileType text         call pencil#init()
  augroup END

" vim-textobj-quote
  augroup textobj_quote
  autocmd!
  autocmd FileType markdown call textobj#quote#init()
  autocmd FileType textile call textobj#quote#init()
  autocmd FileType text call textobj#quote#init({'educate': 0})
  augroup END

" vim-textobj-sentence
  augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
  augroup END

" vim-titlecase
  nmap <leader>gz  <Plug>Titlecase
  vmap <leader>gz  <Plug>Titlecase
  nmap <leader>gzz <Plug>TitlecaseLine

" vim-multiple-cursors
  let g:multi_cursor_use_default_mapping=0
  let g:multi_cursor_start_word_key      = '<C-n>'
  let g:multi_cursor_select_all_word_key = '<A-n>'
  let g:multi_cursor_start_key           = 'g<C-n>'
  let g:multi_cursor_select_all_key      = 'g<A-n>'
  let g:multi_cursor_next_key            = '<C-n>'
  let g:multi_cursor_prev_key            = '<C-p>'
  let g:multi_cursor_skip_key            = '<C-x>'
  let g:multi_cursor_quit_key            = '<Esc>'

" vim-litecorrect
  augroup litecorrect
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
  autocmd FileType textile call litecorrect#init()
  augroup END

" vim-lexical

" vim-windowswap
	let g:windowswap_map_keys = 0 "prevent default bindings
	nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
	nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
	nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" rainbow
	let g:rainbow_active = 1

" vim-pathogen
  execute pathogen#infect()

" }}}

" Autocommands {{{

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_markdown
  autocmd!
  autocmd FileType markdown set textwidth=70
augroup END

" }}}

" Finding Files {{{

  " Search down into subfolders
  " Provides tab-completion for all file-related tasks
  set path+=**
  "
  " Display all matching files when we tab complete
  set wildmenu
  "
  " Now we can:
  " - hit tab to :find by partial match
  " - use * to make it fuzzy
  "
  " Things to consider:
  " - :b lets you autocomplete any open buffer

" }}}

" Tag Jumping {{{

  " Create the `tags` file
  command! MakeTags !ctags -R .
  "
  " Now we can:
  " - use ^] to jump to tag under cursor
  " - use g^] for ambiguous tags
  " - use ^t to jump back up the tag stack
  "
  " Thins to consider:
  " - This doesn't helpl if you want a visual list of tags

" }}}

" Built-in File Manager netrw {{{
let g:netrw_banner=0 " disable annoying banner
let g:netrw_browse_split=4 "open in prior window
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyle=3 " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" :edit a folder to open a file browser
" <CR>/v/t to open in an h-split/v-split/tab
" check |netrw-browse-maps| for more mappings
" }}}

" Build Integration {{{

  " Steal Mr. Bradley's formatter & add it to our spec_helper
  " http://philipbradley.net/rspec-into-vim-with-quickfix
  "
  " Configure the `make` command to run RSpec
  set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter
  "
  " Now we can:
  " - Run :make to run RSpec
  " - :cl to list errors
  " - :cc# to jump to error by number
  " - :cn and :cp to navigate forward and back

" }}}

" Remove unnecessary extra chars {{{

    " Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" }}}
