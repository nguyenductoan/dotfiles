-- ===================== LSP =====================
-- NOTE: This file is meant to be symlinked into ~/.config/nvim/lua
-- "ln -s /Users/nguyenductoan/works/personal/dotfiles/config/nvim/lua ~/.config/nvim/lua"

vim.lsp.config("ruby_lsp", {
  cmd          = { "ruby-lsp" },
  cmd_env      = { BUNDLE_GEMFILE = "/Users/nguyenductoan/works/tools/vscode-ruby-gemfile/Gemfile" },
  filetypes    = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" },
})
vim.lsp.enable("ruby_lsp")

-- Diagnostic highlight overrides — re-applied after every colorscheme load
local function set_diagnostic_highlights()
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#db4b4b", bg = "#2d1b1b", italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#e0af68", bg = "#2d2510", italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#0db9d7", bg = "#0d2030", italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#1abc9c", bg = "#0d2420", italic = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError",   { sp = "#db4b4b", undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",    { sp = "#e0af68", undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",    { sp = "#0db9d7", undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",    { sp = "#1abc9c", undercurl = true })
end

set_diagnostic_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  group    = vim.api.nvim_create_augroup("DiagnosticHighlights", { clear = true }),
  callback = set_diagnostic_highlights,
})

-- Diagnostic signs + config
local icons = { Error = "", Warn = "", Info = "", Hint = "" }
for type, icon in pairs(icons) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs         = true,
  underline     = true,
  severity_sort = true,
  -- Inline text: icon + message after the line
  virtual_text  = {
    spacing = 4,
    prefix  = function(diag)
      return icons[vim.diagnostic.severity[diag.severity]] or "●"
    end,
  },
  -- Floating window: rounded border + source label
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = function(diag)
      local icon = icons[vim.diagnostic.severity[diag.severity]] or "●"
      local hl   = "DiagnosticSign" .. vim.diagnostic.severity[diag.severity]:gsub("^%l", string.upper)
      return icon .. " ", hl
    end,
  },
})

-- Keymaps and auto-float on attach
local augroup = vim.api.nvim_create_augroup("LspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group    = augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "ruby_lsp" then return end
    local opts = { silent = true, buffer = args.buf }
    vim.keymap.set("n", "gd",         require("fzf-lua").lsp_definitions,  opts)
    vim.keymap.set("n", "gr",         require("fzf-lua").lsp_references,   opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,                  opts)
    vim.keymap.set("n", "U",          vim.lsp.buf.hover,                   opts)
    vim.keymap.set("n", "<leader>ge", vim.diagnostic.setloclist,           opts)
    vim.keymap.set("n", "<leader>gE", function()
      vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
    end, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer   = args.buf,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
      end,
    })
  end,
})
