local pid = vim.fn.getpid() -- why did I do this again? ☺
local Plug = vim.fn['plug#'] -- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
local plugin_loc = '~/.vimplugins' -- Plugin location

-- [[ vimplug ]]{{{
vim.call('plug#begin', plugin_loc)
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
        Plug 'nvim-lualine/lualine.nvim'
        Plug 'nvim-tree/nvim-web-devicons'
    -- utilities
        Plug 'mhinz/vim-grepper'
    -- rust
        Plug 'rust-lang/rust.vim'
vim.call('plug#end')
-- }}}
-- [[ lsp setup ]]{{{
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
-- [[ rust ]]
    require("langs/rust")
-- [[ keymaps ]]
    -- [[ https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua ]]
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- }}}
-- [[ ricing ]]{{{
vim.cmd([[colorscheme iceberg]])
require("lualine-config")
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
-- }}}
-- [[ keymaps ]]{{{

vim.keymap.set('n', '<A-n>', ':nohl<CR>', { noremap = true, desc = "Clear regex search (:nohl)" })
vim.keymap.set('n', '<A-r>', ':resize', { noremap = true, desc = "Force resize" })

-- [[ tab ]]{{{
vim.keymap.set('n', '<A-;><A-[>', ':tabnew<CR>', { noremap = true; desc = "New tab" })
vim.keymap.set('n', '<A-;><A-]>', ':tabclose<CR>', { noremap = true; desc = "Close tab" })
vim.keymap.set('n', '<A-;><A-\\>', ':tabedit %<CR>', { noremap = true; desc = "New tab of this file/directory" })

vim.keymap.set('n', '<A-\'><A-\'>', ':tabnext<CR>', { noremap = true; desc = "Next tab" })
vim.keymap.set('n', '<A-;><A-;>', ':tabprev<CR>', { noremap = true; desc = "Previous tab" })
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
-- }}}
-- [[ modeline ]]{{{
local modeline = "fdm=marker fdc=4"
vim.keymap.set("n", "<A-;>ml", "Govim: " .. modeline .. "<Esc>", { desc = "Append the modeline (changes often!)" })

vim.api.nvim_create_user_command('ApplyModeline', function()
    vim.cmd([[setlocal ]] .. modeline)
    vim.notify([[Applied ]] .. modeline)
end, { desc = "Set as modeline for window" })
-- }}}
-- vim: fdm=marker fdc=4
