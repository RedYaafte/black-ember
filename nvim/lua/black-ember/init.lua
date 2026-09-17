local M = {}

local defaults = {
  transparent = false,
  italic_comments = true,
}

local options = vim.deepcopy(defaults)

function M.setup(user_options)
  options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), user_options or {})
end

local function highlight(groups)
  for name, value in pairs(groups) do
    vim.api.nvim_set_hl(0, name, value)
  end
end

function M.load()
  local c = require("black-ember.palette")
  local ui, s, d, vcs = c.ui, c.syntax, c.diagnostic, c.vcs
  local background = options.transparent and "NONE" or ui.background

  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "black-ember"

  for index, color in ipairs(c.terminal.normal) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
  for index, color in ipairs(c.terminal.bright) do
    vim.g["terminal_color_" .. (index + 7)] = color
  end

  highlight({
    Normal = { fg = ui.foreground, bg = background },
    NormalNC = { fg = ui.foreground, bg = background },
    NormalFloat = { fg = ui.foreground, bg = ui.surface },
    FloatBorder = { fg = ui.border, bg = ui.surface },
    FloatTitle = { fg = ui.accent_secondary, bg = ui.surface, bold = true },
    ColorColumn = { bg = ui.background_deep },
    Conceal = { fg = ui.muted },
    Cursor = { fg = ui.background, bg = ui.cursor },
    CursorIM = { fg = ui.background, bg = ui.cursor },
    CursorColumn = { bg = ui.background_deep },
    CursorLine = { bg = ui.background_deep },
    CursorLineFold = { fg = ui.accent_secondary, bg = ui.background_deep },
    CursorLineNr = { fg = ui.accent_secondary, bg = ui.background_deep, bold = true },
    Directory = { fg = ui.accent_secondary },
    EndOfBuffer = { fg = ui.background },
    FoldColumn = { fg = ui.muted, bg = background },
    Folded = { fg = ui.muted, bg = ui.surface },
    LineNr = { fg = ui.punctuation, bg = background },
    MatchParen = { fg = ui.foreground_bright, bg = ui.overlay, bold = true },
    ModeMsg = { fg = ui.foreground_bright, bold = true },
    MoreMsg = { fg = s.string },
    NonText = { fg = ui.surface },
    Pmenu = { fg = ui.foreground, bg = ui.surface },
    PmenuSel = { fg = ui.foreground_bright, bg = ui.overlay, bold = true },
    PmenuSbar = { bg = ui.surface },
    PmenuThumb = { bg = ui.overlay },
    Question = { fg = s.string },
    QuickFixLine = { fg = ui.foreground_bright, bg = ui.overlay, bold = true },
    Search = { fg = ui.background, bg = ui.accent_secondary },
    CurSearch = { fg = ui.background, bg = ui.accent, bold = true },
    IncSearch = { fg = ui.background, bg = ui.accent, bold = true },
    SignColumn = { fg = ui.muted, bg = background },
    SpecialKey = { fg = ui.punctuation },
    SpellBad = { sp = d.error, undercurl = true },
    SpellCap = { sp = d.warning, undercurl = true },
    SpellLocal = { sp = d.info, undercurl = true },
    SpellRare = { sp = d.hint, undercurl = true },
    StatusLine = { fg = ui.foreground, bg = ui.surface },
    StatusLineNC = { fg = ui.muted, bg = ui.background_deep },
    TabLine = { fg = ui.muted, bg = ui.background_deep },
    TabLineFill = { bg = ui.background_deep },
    TabLineSel = { fg = ui.foreground_bright, bg = ui.surface, bold = true },
    Title = { fg = ui.accent_secondary, bold = true },
    Visual = { bg = ui.selection },
    VisualNOS = { bg = ui.selection },
    WarningMsg = { fg = d.warning },
    WildMenu = { fg = ui.foreground_bright, bg = ui.overlay },
    WinBar = { fg = ui.foreground, bg = background },
    WinBarNC = { fg = ui.muted, bg = background },
    WinSeparator = { fg = ui.border },
    
    Comment = { fg = s.comment, italic = options.italic_comments },
    Constant = { fg = s.constant },
    String = { fg = s.string },
    Character = { fg = s.string },
    Number = { fg = s.number },
    Boolean = { fg = s.constant },
    Float = { fg = s.number },
    Identifier = { fg = s.variable },
    Function = { fg = s.function_ },
    Statement = { fg = s.keyword },
    Conditional = { fg = s.keyword },
    Repeat = { fg = s.keyword },
    Label = { fg = s.keyword },
    Operator = { fg = s.operator },
    Keyword = { fg = s.keyword },
    Exception = { fg = d.error },
    PreProc = { fg = s.property },
    Include = { fg = s.keyword },
    Define = { fg = s.property },
    Macro = { fg = s.property },
    PreCondit = { fg = s.property },
    Type = { fg = s.type },
    StorageClass = { fg = s.keyword },
    Structure = { fg = s.type },
    Typedef = { fg = s.type },
    Special = { fg = s.property },
    Delimiter = { fg = s.punctuation },
    SpecialComment = { fg = s.comment, italic = options.italic_comments },
    Debug = { fg = d.warning },
    Underlined = { underline = true },
    Ignore = { fg = ui.muted },
    Error = { fg = d.error },
    Todo = { fg = ui.background, bg = d.warning, bold = true },

    DiagnosticError = { fg = d.error },
    DiagnosticWarn = { fg = d.warning },
    DiagnosticInfo = { fg = d.info },
    DiagnosticHint = { fg = d.hint },
    DiagnosticOk = { fg = s.string },
    DiagnosticUnderlineError = { sp = d.error, undercurl = true },
    DiagnosticUnderlineWarn = { sp = d.warning, undercurl = true },
    DiagnosticUnderlineInfo = { sp = d.info, undercurl = true },
    DiagnosticUnderlineHint = { sp = d.hint, undercurl = true },

    DiffAdd = { fg = vcs.added, bg = ui.background_deep },
    DiffChange = { fg = vcs.modified, bg = ui.background_deep },
    DiffDelete = { fg = vcs.removed, bg = ui.background_deep },
    DiffText = { fg = ui.foreground_bright, bg = ui.overlay },
    Added = { fg = vcs.added },
    Changed = { fg = vcs.modified },
    Removed = { fg = vcs.removed },

    ["@comment"] = { fg = s.comment, italic = options.italic_comments },
    ["@keyword"] = { fg = s.keyword },
    ["@keyword.function"] = { fg = s.keyword },
    ["@keyword.return"] = { fg = s.keyword },
    ["@conditional"] = { fg = s.keyword },
    ["@repeat"] = { fg = s.keyword },
    ["@exception"] = { fg = d.error },
    ["@operator"] = { fg = s.operator },
    ["@string"] = { fg = s.string },
    ["@string.escape"] = { fg = s.property },
    ["@character"] = { fg = s.string },
    ["@number"] = { fg = s.number },
    ["@boolean"] = { fg = s.constant },
    ["@constant"] = { fg = s.constant },
    ["@constant.builtin"] = { fg = s.constant },
    ["@function"] = { fg = s.function_ },
    ["@function.builtin"] = { fg = s.function_ },
    ["@function.call"] = { fg = s.function_ },
    ["@function.method"] = { fg = s.function_ },
    ["@constructor"] = { fg = s.type },
    ["@type"] = { fg = s.type },
    ["@type.builtin"] = { fg = s.type },
    ["@variable"] = { fg = s.variable },
    ["@variable.builtin"] = { fg = s.property },
    ["@property"] = { fg = s.property },
    ["@field"] = { fg = s.property },
    ["@parameter"] = { fg = ui.foreground },
    ["@punctuation.delimiter"] = { fg = s.punctuation },
    ["@punctuation.bracket"] = { fg = s.punctuation },
    ["@tag"] = { fg = s.keyword },
    ["@tag.attribute"] = { fg = s.property },
    ["@tag.delimiter"] = { fg = s.punctuation },
    ["@markup.heading"] = { fg = ui.accent_secondary, bold = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.link"] = { fg = d.info, underline = true },

    ["@lsp.type.class"] = { fg = s.type },
    ["@lsp.type.decorator"] = { fg = s.property },
    ["@lsp.type.enum"] = { fg = s.type },
    ["@lsp.type.enumMember"] = { fg = s.constant },
    ["@lsp.type.function"] = { fg = s.function_ },
    ["@lsp.type.interface"] = { fg = s.type },
    ["@lsp.type.macro"] = { fg = s.property },
    ["@lsp.type.method"] = { fg = s.function_ },
    ["@lsp.type.namespace"] = { fg = s.type },
    ["@lsp.type.parameter"] = { fg = ui.foreground },
    ["@lsp.type.property"] = { fg = s.property },
    ["@lsp.type.struct"] = { fg = s.type },
    ["@lsp.type.type"] = { fg = s.type },
    ["@lsp.type.typeParameter"] = { fg = s.type },
    ["@lsp.type.variable"] = { fg = s.variable },

    GitSignsAdd = { fg = vcs.added },
    GitSignsChange = { fg = vcs.modified },
    GitSignsDelete = { fg = vcs.removed },
    TelescopeNormal = { fg = ui.foreground, bg = ui.surface },
    TelescopeBorder = { fg = ui.border, bg = ui.surface },
    TelescopePromptNormal = { fg = ui.foreground, bg = ui.background_deep },
    TelescopePromptBorder = { fg = ui.border, bg = ui.background_deep },
    TelescopePromptTitle = { fg = ui.background, bg = ui.accent },
    TelescopePreviewTitle = { fg = ui.background, bg = d.info },
    TelescopeResultsTitle = { fg = ui.background, bg = s.string },
    TelescopeSelection = { fg = ui.foreground_bright, bg = ui.overlay, bold = true },
    CmpItemAbbr = { fg = ui.foreground },
    CmpItemAbbrDeprecated = { fg = ui.muted, strikethrough = true },
    CmpItemAbbrMatch = { fg = ui.accent_secondary, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = ui.accent_secondary, bold = true },
    CmpItemKind = { fg = s.type },
    CmpItemMenu = { fg = ui.muted },
  })
end

return M
