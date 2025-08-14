local builtin = require("telescope.builtin")
-- Telescope mappings
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fe", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

-- Yank to system clipboard with <leader>y (normal and visual mode)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

-- Yank whole line to system clipboard with <leader>Y
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from system clipboard with <leader>p (normal and visual mode)
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')


vim.keymap.set("n", "<Leader>dt", function()
  require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dc", function()
  require("dap").continue()
end)

local M = {}

-- Global (non-LSP-specific) keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP: Show diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format current buffer with LSP" })
-- Function to attach LSP-specific keymaps
function M.on_attach(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("keep", { desc = "LSP: Go to definition" }, opts))
  vim.keymap.set(
    "n",
    "gD",
    vim.lsp.buf.declaration,
    vim.tbl_extend("keep", { desc = "LSP: Go to declaration" }, opts)
  )
  vim.keymap.set(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    vim.tbl_extend("keep", { desc = "LSP: Go to implementation" }, opts)
  )
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("keep", { desc = "LSP: Find references" }, opts))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("keep", { desc = "LSP: Hover doc" }, opts))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("keep", { desc = "LSP: Rename symbol" }, opts))
  vim.keymap.set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    vim.tbl_extend("keep", { desc = "LSP: Code actions" }, opts)
  )
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend("keep", { desc = "LSP: Format buffer" }, opts))
end

return M
