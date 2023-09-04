local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.rust_analyzer.setup({
    on_attach = require'langs/common'.on_attach
})

vim.g.rustfmt_autosave = 1
