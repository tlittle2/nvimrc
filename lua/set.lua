local utils = require("utils")

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
vim.opt.updatetime = 250
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


vim.keymap.set(utils.vim.mode.normal, '<Esc>', utils.vim.runVimCommand('nohlsearch'))

--go back to normal mode after allocating new line
vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader("o"), 'o<Esc>')
vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader("O"), 'O<Esc>')


--stay in 'indent' mode after indenting
vim.keymap.set(utils.vim.mode.visual, '<', '<gv')
vim.keymap.set(utils.vim.mode.visual, '>', '>gv')

--keep cursor centered while scrolling
vim.keymap.set(utils.vim.mode.normal,'<C-d>', '<C-d>zz')
vim.keymap.set(utils.vim.mode.normal,'<C-u>', '<C-u>zz')
vim.keymap.set(utils.vim.mode.normal,'<C-f>', '<C-f>zz')
vim.keymap.set(utils.vim.mode.normal,'<C-b>', '<C-b>zz')


vim.keymap.set(utils.vim.mode.normal, '<Esc>', utils.vim.runVimCommand('nohlsearch'))


-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set(utils.vim.mode.terminal, '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set(utils.vim.mode.normal, '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set(utils.vim.mode.normal, '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set(utils.vim.mode.normal, '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set(utils.vim.mode.normal, '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set(utils.vim.mode.normal, 'Q', '<Nop>')


-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set(utils.vim.mode.normal, '<A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set(utils.vim.mode.normal, '<A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set(utils.vim.mode.normal, '<A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set(utils.vim.mode.normal, '<A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })


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
