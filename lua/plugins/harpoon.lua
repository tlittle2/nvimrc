local utils = require("utils")

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    local harpoonList = {
      [1] = "h",
      [2] = "j",
      [3] = "k",
      [4] = "l"
    }

    utils.loop(harpoonList, function(idx, key)
      vim.keymap.set(utils.vim.mode.normal, utils.vim.key.ctrl(key), function() harpoon:list():select(idx) end)
    end)


    local keymaps = {
      [utils.vim.prefixLeader("a")] = function() harpoon:list():add() end,
      [utils.vim.key.ctrl("e")] = function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,

      --Toggle previous & next buffers stored within Harpoon list
      [utils.vim.key.ctrl("S-P")] = function() harpoon:list():prev() end,
      [utils.vim.key.ctrl("S-N")] = function() harpoon:list():next() end,
    }

    utils.loop(keymaps, function(k, v)
      vim.keymap.set(utils.vim.mode.normal, k, v)
    end)

  end
}
