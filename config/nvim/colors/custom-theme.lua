-- Colorscheme: custom-theme
-- Generated from iTerm2 profile: nguyenductoan
-- Syntax colours based on Terafox (nightfox.nvim)

vim.opt.background = "dark"
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "custom-theme"

-- ── Palette ────────────────────────────────────────────────────────────────
-- iTerm UI colours
local ui = {
  bg       = "#09141B",
  fg       = "#E8D3BB",
  bg_light = "#18384D",  -- selection, cursorline, statusline bg
  gray     = "#434B53",
  teal     = "#358794",
  cyan     = "#50A3B5",
  tan      = "#DEB88D",
  yellow   = "#FDD39F",
  bright_c = "#1FE0DD",
  green    = "#43D24D",
  green2   = "#3ACB5E",
  orange   = "#FCA02F",
  red      = "#D23C28",
  red2     = "#D15123",
  blue     = "#6BB8D0",
}

-- Background #1e4862  Foreground #fee3cd  Badge #ff0000
local palette = {
  black   = { normal = "#17384c", bright = "#424b52" },
  red     = { normal = "#d15023", bright = "#d13c27" },
  green   = { normal = "#027c9b", bright = "#42d14c" },
  yellow  = { normal = "#fca02f", bright = "#fdd29e" },
  blue    = { normal = "#358794", bright = "#1fdfdd" },
  magenta = { normal = "#2a8f38", bright = "#6bb8cf" },
  cyan    = { normal = "#50a3b5", bright = "#3aca5d" },
  white   = { normal = "#deb88d", bright = "#fee3cd" },
}

-- Terafox syntax colours
local syn = {
  comment  = "#6d7f8b",
  string   = palette.yellow.bright,
  number   = "#ff8349",
  const    = palette.yellow.normal,
  func     = palette.green.normal,
  ident    = palette.green.normal,
  keyword  = palette.magenta.normal,
  cond     = palette.yellow.normal,
  type     = palette.yellow.normal,
  preproc  = palette.green.normal,
  operator = palette.white.bright,
  tag      = palette.red.normal,
  error    = palette.red.bright,
}

-- ── Helper ─────────────────────────────────────────────────────────────────
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Syntax ─────────────────────────────────────────────────────────────────
hi("Normal",        { fg = ui.fg,       bg = ui.bg })
hi("Comment",       { fg = syn.comment, italic = true })
hi("Constant",      { fg = syn.const })
hi("String",        { fg = syn.string })
hi("Character",     { fg = syn.string })
hi("Number",        { fg = syn.number })
hi("Boolean",       { fg = syn.const })
hi("Float",         { fg = syn.number })
hi("Identifier",    { fg = syn.ident })
hi("Function",      { fg = syn.func })
hi("Statement",     { fg = syn.keyword })
hi("Keyword",       { fg = syn.keyword })
hi("Conditional",   { fg = syn.cond })
hi("Repeat",        { fg = syn.cond })
hi("Label",         { fg = syn.keyword })
hi("Operator",      { fg = syn.operator })
hi("Exception",     { fg = syn.error })
hi("PreProc",       { fg = syn.preproc })
hi("Include",       { fg = syn.preproc })
hi("Define",        { fg = syn.preproc })
hi("Macro",         { fg = syn.preproc })
hi("Type",          { fg = syn.type })
hi("StorageClass",  { fg = syn.type })
hi("Structure",     { fg = syn.type })
hi("Typedef",       { fg = syn.type })
hi("Special",       { fg = syn.ident })
hi("SpecialChar",   { fg = syn.const })
hi("Tag",           { fg = syn.tag })
hi("Delimiter",     { fg = syn.operator })
hi("SpecialComment",{ fg = syn.comment, italic = true })
hi("Error",         { fg = syn.error,   bold = true })
hi("Todo",          { fg = syn.const,   bold = true })
hi("Underlined",    { underline = true })

-- ── UI ─────────────────────────────────────────────────────────────────────
hi("LineNr",        { fg = ui.teal })
hi("CursorLineNr",  { fg = ui.yellow })
hi("CursorLine",    { bg = ui.bg_light })
hi("ColorColumn",   { bg = ui.bg_light })
hi("SignColumn",    { fg = ui.teal })
hi("VertSplit",     { fg = ui.bg_light })
hi("Folded",        { fg = ui.cyan,    bg = ui.bg_light })
hi("FoldColumn",    { fg = ui.cyan })
hi("Search",        { fg = ui.bg,      bg = ui.yellow })
hi("IncSearch",     { fg = ui.bg,      bg = ui.bright_c })
hi("Visual",        { bg = ui.bg_light })
hi("StatusLine",    { fg = ui.fg,      bg = ui.bg_light })
hi("StatusLineNC",  { fg = ui.gray,    bg = ui.bg_light })
hi("WildMenu",      { fg = ui.bg,      bg = ui.bright_c })
hi("Pmenu",         { fg = ui.fg,      bg = ui.bg_light })
hi("PmenuSel",      { fg = ui.bg,      bg = ui.bright_c })
hi("PmenuSbar",     { bg = ui.bg_light })
hi("PmenuThumb",    { bg = ui.cyan })
hi("TabLine",       { fg = ui.gray,    bg = ui.bg_light })
hi("TabLineSel",    { fg = ui.fg,      bg = ui.bg })
hi("TabLineFill",   { bg = ui.bg_light })
hi("Title",         { fg = ui.green,   bold = true })
hi("Directory",     { fg = palette.blue.normal, bold = false })
hi("NonText",       { fg = ui.bg_light })
hi("SpecialKey",    { fg = ui.bg_light })
hi("MatchParen",    { fg = ui.orange,  bold = true, underline = true })
hi("ErrorMsg",      { fg = ui.red })
hi("WarningMsg",    { fg = ui.orange })
hi("ModeMsg",       { fg = ui.green })
hi("MoreMsg",       { fg = ui.green })
hi("Question",      { fg = ui.green })

-- ── Diff ───────────────────────────────────────────────────────────────────
hi("DiffAdd",       { fg = ui.green })
hi("DiffChange",    { fg = ui.orange })
hi("DiffDelete",    { fg = ui.red })
hi("DiffText",      { fg = ui.yellow,  bold = true })

-- ── Git gutter ─────────────────────────────────────────────────────────────
hi("GitGutterAdd",    { fg = ui.green })
hi("GitGutterChange", { fg = ui.orange })
hi("GitGutterDelete", { fg = ui.red })

-- ── Treesitter ──────────────────────────────────────────────────────────────
hi("@keyword.function", { fg = palette.magenta.normal })  -- def, end (method)
hi("@function",         { fg = palette.blue.normal })    -- method name definition
hi("@function.method",  { fg = palette.blue.normal })    -- method name (alt capture)
hi("@function.call",    { fg = palette.cyan.normal }) -- bare method calls (has_many, has_one, …)
hi("@variable.member",  { fg = palette.magenta.bright })    -- instance vars (@foo), class vars (@@foo)
hi("@string.content",   { fg = syn.string })
hi("@string.delimiter", { fg = palette.magenta.normal })
