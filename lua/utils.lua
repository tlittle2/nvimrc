return {
   vim = {
      mode = {
          normal = 'n',
          visual = 'v',
          terminal = 't',
      },

      prefixLeader = function(keymap)
          return "<leader>" .. keymap
      end,

      runVimCommand = function(command)
          return "<cmd>" .. command .. "<CR>"
      end
  }
}

