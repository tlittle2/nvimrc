local utils = require("utils")

local mode = utils.vim.mode
local key = utils.vim.key

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false
--vim.g.python3_host_prog = "C:/Users/Trevor Little/AppData/Local/Programs/Python/Python311/python.exe"

vim.opt.mouse = 'a'
vim.cmd("setlocal spell spelllang=en_us")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.confirm = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth= 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.guicursor = ""
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- NOTE: Singular remaps

-- This won't work in all terminal emulators/tmux/etc. Try your own mapping or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(mode.terminal, '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set(mode.normal, '<Esc>', utils.vim.runVimCommand('nohlsearch'))
vim.keymap.set(utils.vim.mode.normal, 'Q', '<Nop>')

-- NOTE: "utils.loop" remaps

-- go back to normal mode after allocating new line
utils.loop({"o", "O"}, function(_, v) vim.keymap.set(mode.normal, utils.vim.prefixLeader(v), v ..'<Esc>') end)

--stay in 'indent' mode after indenting
utils.loop({">", "<"}, function(_, v) vim.keymap.set(mode.visual, v, v .. 'gv') end)


--keep cursor centered while scrolling
local pageKeys = {
  ["d"] = "half-page down",
  ["u"] = "half-page up",
  ["b"] = "full-page down",
  ["f"] = "full-page up",
}

utils.loop(pageKeys, function(k, _) vim.keymap.set(mode.normal, key.ctrl(k), key.ctrl(k) .. 'zz') end)


local directions = {
  ["left"] = "h",
  ["right"] = "l",
  ["up"] = "k",
  ["down"] = "j",
}

--Disable arrow keys in normal/visual mode
utils.loop(directions, function(arrow,vim_key)
  local message = "Use " .. vim_key  .. " to move!!"
  vim.keymap.set({mode.normal, mode.visual}, utils.string.inBrackets(arrow) , utils.vim.runVimCommand("echo " .. utils.string.sQuote(message)))
end)


--Keybinds to make split navigation easier.
--Use ALT+<hjkl> to switch between windows
--See `:help wincmd` for a list of all window commands
utils.loop(directions, function(direction,vim_key)
  vim.keymap.set(mode.normal, key.alt(vim_key), key.ctrl("w") .. key.ctrl(vim_key), { desc = 'Move focus to the ' .. direction .. ' window' })
end)


-- NOTE: "run" current file
vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader("r"), function()

  local runsplit = function(program)
    return 'split | terminal ' .. program .. " " .. vim.fn.fnameescape(vim.fn.expand('%:p'))
  end

  local ft = vim.bo.filetype
  vim.cmd("w")

  local tbl = {
    --["python"] = runsplit('python3'),
    ["python"] = runsplit('python'),
    ["lua"] = runsplit('lua54'),
    ["go"] = runsplit('go run'),
    ["rust"] = runsplit('cargo run'),
    ["markdown"] = 'PresentStart',
  }


  vim.cmd(tbl[ft])
  vim.cmd('startinsert')

end , {desc = "execute current file"}
)
