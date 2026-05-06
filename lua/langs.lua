local lspconfig = vim.lsp.config;
local configs = require("lspconfig.configs");
local util = require("lspconfig.util")

-- NOTE: Remember that lua is a real programming language, and as such it is possible
-- to define small helper and utility functions so you don't have to repeat yourself
-- many times.
--
-- In this case, we create a function that lets us more easily define mappings specific
-- for LSP related items. It sets the mode, buffer and description for us each time.
local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

-- [[ Common ]]{{{
    -- [[ https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua ]]

    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach_common = function(_, bufnr)
        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        -- nmap('<leader>a', vim.lsp.buf.code_action, '[C]ode [A]ction')
        -- nmap('<C-a>', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end

    -- Update error messages even while you're typing in insert mode
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = { spacing = 4 },
        update_in_insert = true,
      }
    )

    vim.lsp.config('*', {
        lsp = { on_attach = on_attach_common }
    })
-- }}}
-- [[ Rust ]]{{{
    vim.g.rustfmt_autosave = 1
    vim.lsp.enable('rust_analyzer');
-- }}}
-- [[ Haskell ]]{{{
    lspconfig('hls',{
        filetypes = { 'haskell', 'lhaskell', 'cabal' }
    })
    vim.lsp.enable('hls');
-- }}}
-- [[ Java ]]{{{
    vim.lsp.enable('jdtls');
-- }}}
    -- [[ Lean ]]{{{
    -- Enable nvim-cmp, with 3 completion sources, including LSP
    -- local cmp = require'cmp'
    -- cmp.setup{
    --     mapping = cmp.mapping.preset.insert({
    --       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --       ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --       ['<C-Space>'] = cmp.mapping.complete(),
    --       ['<C-e>'] = cmp.mapping.abort(),
    --       ['<CR>'] = cmp.mapping.confirm({ select = true }),
    --     }),
    --     sources = cmp.config.sources({
    --       { name = 'nvim_lsp' },
    --       { name = 'path' },
    --       { name = 'buffer' },
    --     })
    -- }

    -- You may want to reference the nvim-cmp documentation for further
    -- configuration of completion: https://github.com/hrsh7th/nvim-cmp#recommended-configuration

    -- Enable lean.nvim, and enable abbreviations and mappings
    lspconfig('leanls',{
        lsp = { on_attach = function(a, bufnr)
                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                    on_attach_common(a, bufnr)
                end },
        mappings = true,
    })
    vim.lsp.enable('leanls');
-- }}}
-- [[ C/C++ ]]{{{
    lspconfig('ccls',{
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "arduino" },
        init_options = {
            compilationDatabaseDirectory = "build",
            index = {
                threads = 0,
            },
            clang = {
                excludeArgs = { "-frounding-math"},
            },
        }
    })
    vim.lsp.enable('ccls');
--}}}
-- [[ Asymptote ]]{{{
    vim.filetype.add({
        extension = {
            asy = 'asymptote',
        },
    })

    if not configs.asy then
        configs.asy = {
            default_config = {
                cmd = {'asy', '-lsp'},
                filetypes = {'asymptote'},
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end,
                settings = {},
            },
        }
    end
-- }}}
-- [[ LaTeX ]]{{{
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

    vim.g.vimtex_compiler_method = 'latexmk'
    vim.api.nvim_create_autocmd({'BufReadPre'}, {
      pattern = {'*.tex'},
      callback = function(ev)
          local winid = vim.api.nvim_get_current_win()
          vim.wo[winid][0].foldmethod='expr'
          vim.wo[winid][0].foldexpr='vimtex#fold#level(v:lnum)'
          vim.wo[winid][0].foldtext='vimtex#fold#text()'
      end
    })

    vim.g.vimtex_fold_types = {
        preamble = {enabled = 1},
        envs = {blacklist = {'align', 'align*', 'equation', 'equation*'}},
    }
--}}}
-- [[ Keymaps ]]{{{
    -- [[ https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua ]]
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })-- }}}
-- vim: fdm=marker fdc=4
