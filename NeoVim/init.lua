
vim.opt.scrolloff = 999
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    vim.cmd("LspStop")
    vim.defer_fn(function()
      vim.cmd("LspStart")
    end, 100)
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "cold" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("config.keymaps")

-- Use this style for all LSP-related windows
local border = "rounded"

-- Diagnostics float (e.g., <leader>e)
vim.diagnostic.config({
	float = {
		border = border,
	},
	virtual_text = true, -- optional: keep inline virtual text
	signs = true,
	underline = true,
})

-- Diagnostics (like :lua vim.diagnostic.open_float())
vim.diagnostic.config({
	float = { border = border },
})

-- Hover docs (K)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#1e1e1e" })

-- Signature help (when typing function params)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
