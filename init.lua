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
    -- utilities
        Plug 'mhinz/vim-grepper'
    -- rust
        Plug 'rust-lang/rust.vim'
    -- agda
        Plug 'derekelkins/agda-vim'
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
