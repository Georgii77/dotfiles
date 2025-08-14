return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"rust_analyzer", "lua_ls", "html", "ts_ls", "gopls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local on_attach = require("config.keymaps").on_attach
      local default_root_dir = function(fname)
       local util = require("lspconfig.util")
        return util.root_pattern(".git", "package.json", "tsconfig.json")(fname)
          or vim.fn.getcwd()
      end
      local servers = {
        cssls = {},
        lua_ls = {},
        html = {},
        ts_ls = {},
        gopls = {},
        rust_analyzer ={settings = {
            ["rust-analyzer"] = {
              cargo = {
                target = nil,      -- build proc-macros for *host* architecture
              },
              procMacro = {
                enable  = true,
                -- If you still prefer to silence embassy macros instead:
                -- ignored = { embassy_executor = { "*" } },
              },diagnotics = {},
            enableExperimental = true,
            },
          },},
      }
      for server, opts in pairs(servers) do
        opts.on_attach = on_attach
        opts.root_dir = default_root_dir
        opts.capabilities = capabilities
        lspconfig[server].setup(opts)
      end
    end,
  }
}

