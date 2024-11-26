require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local g = vim.g
g.editorconfig = true

local o = vim.o

-- powershell
o.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
o.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\\'Out-File:Encoding\\']=\\'utf8\\';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
o.shellquote = ""
o.shellxquote = ""

-- whitespaces
o.list = true
o.listchars = "tab:»·,trail:·,extends:>,space:·"

o.expandtab = true -- Converts tabs to spaces
o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
o.fixendofline = true -- Ensures that there's always an EOL at the end of the file
o.eol = true -- Make sure the end of line is written
o.endofline = true -- Always append a newline at the end of a file

-- inc-rename
o.inccommand = "split" -- create a window
