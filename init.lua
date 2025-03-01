local pid = vim.fn.getpid() -- why did I do this again? ☺
local Plug = vim.fn['plug#'] -- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local plugin_loc = '~/.vimplugins' -- Plugin location

-- [[ vimplug ]]{{{
vim.call('plug#begin', plugin_loc)
        Plug 'nvim-lua/plenary.nvim'
    -- directory tree
        Plug 'preservim/nerdtree'
    -- git
        Plug 'tpope/vim-fugitive'
        Plug 'christoomey/vim-conflicted'
        Plug 'airblade/vim-gitgutter'
    -- language server
        Plug 'neovim/nvim-lspconfig'
    -- stuff
        Plug 'cocopon/iceberg.vim'
    -- utilities
        Plug 'mhinz/vim-grepper'
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
    -- rust
        Plug 'rust-lang/rust.vim'
    -- agda
        Plug 'derekelkins/agda-vim'
    -- lean
        Plug 'Julian/lean.nvim'
    -- treesitter
        Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
vim.call('plug#end')
-- }}}
-- [[ lsp setup ]]{{{
require("langs")
-- }}}
-- [[ ricing ]]{{{
vim.cmd([[colorscheme iceberg]])
-- }}}
-- [[ settings ]]{{{
vim.cmd([[ syntax enable ]])
vim.cmd([[ filetype plugin indent on ]])

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.completeopt = "menu,menuone,preview"

vim.opt.signcolumn = "yes:1"
-- }}}
-- [[ keymaps ]]{{{

vim.keymap.set('n', ' n', ':nohl<CR>', { noremap = true, desc = "Clear regex search (:nohl)" })
vim.keymap.set('n', ' r', ':resize', { noremap = true, desc = "Force resize" })

-- [[ tab ]]{{{
vim.keymap.set('n', '<Tab>n', ':tabnew<CR>', { noremap = true; desc = "New tab" })
vim.keymap.set('n', '<Tab>d', ':tabclose<CR>', { noremap = true; desc = "Delete (close) tab" })
vim.keymap.set('n', '<Tab>D', ':tabedit %<CR>', { noremap = true; desc = "New tab of this file/directory" })

vim.keymap.set('n', '<Tab>l', ':tabnext<CR>', { noremap = true; desc = "Next tab" })
vim.keymap.set('n', '<Tab>h', ':tabprev<CR>', { noremap = true; desc = "Previous tab" })
-- }}}
-- [[ no arrows, use hjkl ]]{{{
local no_arrows_desc = "use hjkl"
vim.keymap.set('n', '<left>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('n', '<right>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('n', '<up>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('n', '<down>', '<nop>', { noremap = true; desc = no_arrows_desc })

vim.keymap.set('i', '<left>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('i', '<right>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('i', '<up>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('i', '<down>', '<nop>', { noremap = true; desc = no_arrows_desc })

vim.keymap.set('v', '<left>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('v', '<right>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('v', '<up>', '<nop>', { noremap = true; desc = no_arrows_desc })
vim.keymap.set('v', '<down>', '<nop>', { noremap = true; desc = no_arrows_desc })
-- }}}
-- }}}
-- [[ commands ]]{{{
vim.api.nvim_create_user_command("Config", [[
:tabnew
:exe 'tcd '.stdpath('config')
:exe 'edit '.stdpath('config').'/init.lua'
:vs .
:vertical resize 30
]] ,{ desc = 'Go to configuration setup' })
vim.api.nvim_create_user_command("CleanUnnamed", function() 
    vim.iter(vim.api.nvim_list_bufs())
        :filter(vim.api.nvim_buf_is_loaded)
        :filter(function(b) return vim.api.nvim_buf_get_name(b) == "" end)
        :each(function(b) vim.api.nvim_buf_delete(b, { force = true }) end)
end, { desc = 'Clean unnamed buffers'})
-- }}}
-- [[ modeline ]]{{{
local modeline = "fdm=marker fdc=4"
vim.keymap.set("n", "<A-;>ml", "Govim: " .. modeline .. "<Esc>", { desc = "Append the modeline (changes often!)" })

vim.api.nvim_create_user_command('ApplyModeline', function()
    vim.cmd([[setlocal ]] .. modeline)
    vim.notify([[Applied ]] .. modeline)
end, { desc = "Set as modeline for window" })
-- }}}
-- [[ treesitter ]] {{{
require'nvim-treesitter.configs'.setup {
    ensure_installed = {},
    sync_install = true,
    auto_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        custom_captures = {},
        additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<Leader>a",
            node_incremental = "<Leader>s",
            node_decremental = "<Leader>d",
            scope_incremental = "<Leader>f",
        },
    },
    textobjects = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}
-- }}}
-- vim: fdm=marker fdc=4
