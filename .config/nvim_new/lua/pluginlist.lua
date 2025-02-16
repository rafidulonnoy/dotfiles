return {
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {     -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,             -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,           -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,             -- force no italic
        no_bold = false,               -- force no bold
        no_underline = false,          -- force no underline
        styles = {                     -- handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },     -- change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = { "italic" },
          keywords = { "italic", "bold" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  --
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "folke/neodev.nvim",
  },
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    config = true
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.formatter"
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-nvim-lsp',
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },


  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = 'catppuccin',
        },
      })
    end,
  },
  {
    'ThePrimeagen/vim-be-good',
    lazy = true,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local nvimtree = require("nvim-tree")

      -- recommended settings from nvim-tree documentation
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- change color for arrows in tree to light blue
      vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
      vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

      -- configure nvim-tree
      nvimtree.setup({
        view = {
          width = 35,
          relativenumber = true,
        },
        -- change folder arrow icons
        renderer = {
          indent_markers = {
            enable = true,
          },
          -- icons = {
          -- 	glyphs = {
          -- 		folder = {
          -- 			arrow_closed = "", -- arrow when folder is closed
          -- 			arrow_open = "", -- arrow when folder is open
          -- 		},
          -- 	},
          -- },
        },
        -- disable window_picker for
        -- explorer to work well with
        -- window splits
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          custom = { ".DS_Store" },
        },
        git = {
          ignore = false,
        },
      })

      -- set keymaps
      local keymap = vim
          .keymap                                                                                                        -- for conciseness

      keymap.set("n", "<leader>cf", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })                        -- toggle file explorer
      keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
      keymap.set("n", "<leader>ce", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })                    -- collapse file explorer
      keymap.set("n", "<leader>re", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })                      -- refresh file explorer
    end,
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
}
