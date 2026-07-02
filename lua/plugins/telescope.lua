local utils = require("utils")

return   { -- Fuzzy Finder (files, lsp, etc)

  'nvim-telescope/telescope.nvim',
  -- By default, Telescope is included and acts as your picker for everything.

  -- If you would like to switch to a different picker (like snacks, or fzf-lua)
  -- you can disable the Telescope plugin by setting enabled to false and enable
  -- your replacement picker by requiring it explicitly (e.g. 'custom.plugins.snacks')

  -- Note: If you customize your config for yourself,
  -- it’s best to remove the Telescope plugin config entirely
  -- instead of just disabling it here, to keep your config clean.
  enabled = true,
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    }

    -- Enable Telescope extensions if they are installed
    utils.loop({'fzf', 'ui-select'}, function(_,v)
      pcall(require('telescope').load_extension, v)
    end)



    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    local searchMaps = {
      [utils.vim.prefixLeader('sh')]= {builtin.help_tags,'[S]earch [H]elp'},
      [utils.vim.prefixLeader('sk')]= {builtin.keymaps,'[S]earch [K]eymaps'},
      [utils.vim.prefixLeader('sf')]= {builtin.find_files,'[S]earch [F]iles'},
      [utils.vim.prefixLeader('ss')]= {builtin.builtin,'[S]earch [S]elect Telescope'},
      [utils.vim.prefixLeader('sg')]= {builtin.live_grep,'[S]earch by [G]rep'},
      [utils.vim.prefixLeader('sd')]= {builtin.diagnostics,'[S]earch [D]iagnostics'},
      [utils.vim.prefixLeader('sr')]= {builtin.resume,'[S]earch [R]esume'},
      [utils.vim.prefixLeader('s.')]= {builtin.oldfiles,'[S]earch Recent Files ("." for repeat)'},
      [utils.vim.prefixLeader('sc')]= {builtin.commands,'[S]earch [C]ommands'},
      [utils.vim.prefixLeader('<leader>')] = {builtin.buffers,'[ ] Find existing buffers'},
      [utils.vim.prefixLeader('sw')] = {builtin.grep_string,'[S]earch current [W]ord', { utils.vim.mode.normal, utils.vim.mode.visual }}
    }

    utils.loop(searchMaps, function(k,v)
      vim.keymap.set(v[3] or utils.vim.mode.normal, k, v[1], { desc = v[2] })
    end)



    -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
    -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf

        local lspAttachMap = {
          -- Find references for the word under your cursor.
          ['grr'] = { builtin.lsp_references,'[G]oto [R]eferences' },

          -- Jump to the implementation of the word under your cursor
          ['gri'] = { builtin.lsp_implementations,'[G]oto [I]mplementation' },

          -- Jump to the definition of the word under your cursor (where word/function is first defined). jump back with <C-t>
          ['grd'] = { builtin.lsp_definitions,'[G]oto [D]efinition' },

          -- Fuzzy find all the symbols (things like variables, functions, types, etc.) in your current document.
          ['gO'] =  { builtin.lsp_document_symbols, 'Open Document Symbols'},

          -- Fuzzy find all the symbols in your current workspace. Similar to document symbols, except searches over your entire project.
          ['gW'] =  { builtin.lsp_dynamic_workspace_symbols,'Open Workspace Symbols'},

          -- Jump to the type of the word under your cursor. Useful when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.
          ['grt'] = { builtin.lsp_type_definitions,'[G]oto [T]ype Definition' },
        }

        utils.loop(lspAttachMap, function(k, v) vim.keymap.set(utils.vim.mode.normal, k, v[1], { buffer = buf, desc = v[2] }) end)
      end,
    })


    vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader('/'), function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader('s/'),
      function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files', }
      end, { desc = '[S]earch [/] in Open Files' }
    )

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader('sn'), function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' }
    )
  end,
}
