local cmd = vim.cmd
-- blankline

cmd "hi IndentBlanklineChar guifg=#242831"

-- misc --
cmd "hi LineNr guifg=#3b4352"
cmd "hi LineNr guibg=#2e3440"
cmd "hi SignColumn guibg=#2e3440"

cmd "hi NvimInternalError guifg=#bf616a"
cmd "hi VertSplit guifg=#2e3440"
cmd "hi EndOfBuffer guifg=#2e3440"

-- Pmenu
cmd "hi PmenuSel guibg=#a3be8c"
cmd "hi Pmenu  guibg=#242831"
cmd "hi PmenuSbar guibg =#3b4252"
cmd "hi PmenuThumb guibg =#81A1C1"

-- inactive statuslines as thin splitlines
cmd("highlight! StatusLineNC gui=underline guifg=#3b4252")

-- line n.o
cmd "hi clear CursorLine"
cmd "hi cursorlinenr guifg=#e5e9f0"

-- git signs ---
cmd "hi DiffAdd guifg=#81A1C1 guibg = none"
cmd "hi DiffChange guifg =#3b4252 guibg = none"
cmd "hi DiffModified guifg = #81A1C1 guibg = none"

-- NvimTree
cmd "hi NvimTreeFolderIcon guifg = #81a1c1"
cmd "hi NvimTreeFolderName guifg = #81a1c1"
cmd "hi NvimTreeIndentMarker guifg=#383c44"
cmd "hi NvimTreeNormal guibg=#2e3440"
cmd "hi NvimTreeVertSplit guifg=#242831"
cmd "hi NvimTreeRootFolder guifg=#bf616a"

-- telescope
cmd "hi TelescopeBorder   guifg=#242831"
cmd "hi TelescopePromptBorder   guifg=#242831"
cmd "hi TelescopeResultsBorder  guifg=#242831"
cmd "hi TelescopePreviewBorder  guifg=#525865"

-- LspDiagnostics ---

-- error / warnings
cmd "hi LspDiagnosticsSignError guifg=#bf616a"
cmd "hi LspDiagnosticsVirtualTextError guifg=#BF616A"
cmd "hi LspDiagnosticsSignWarning guifg=#EBCB8B"
cmd "hi LspDiagnosticsVirtualTextWarning guifg=#EBCB8B"

-- info
cmd "hi LspDiagnosticsSignInformation guifg=#A3BE8C"
cmd "hi LspDiagnosticsVirtualTextInformation guifg=#A3BE8C"

-- hint
cmd "hi LspDiagnosticsSignHint guifg=#e5e9f0"
cmd "hi LspDiagnosticsVirtualTextHint guifg=#e5e9f0"
