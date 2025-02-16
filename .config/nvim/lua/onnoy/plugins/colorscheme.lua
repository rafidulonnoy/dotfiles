function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- catppuccin theme

return {
	-- Sonokai Theme
	{
		-- https://github.com/sainnhe/sonokai
		"sainnhe/sonokai",
		--   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
		priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
		config = function(_, opts)
			vim.g.sonokai_style = "default" -- "default, atlantis, andromeda, shusia, maia, espresso"
      vim.g.sonokai_transparent_background = 1
			-- vim.cmd("colorscheme sonokai") -- Replace this with your favorite colorscheme
		end,
	},
	-- Kanagawa Theme (Original)
	{
		-- https://github.com/rebelot/kanagawa.nvim
		"rebelot/kanagawa.nvim", -- You can replace this with your favorite colorscheme
		--   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
		priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
		opts = {
			-- Replace this with your scheme-specific settings or remove to use the defaults
			transparent = true,
			background = {
				-- light = "lotus",
				dark = "wave", -- "wave, dragon"
			},
		},
		config = function(_, opts)
			require("kanagawa").setup(opts) -- Replace this with your favorite colorscheme
			-- vim.cmd("colorscheme kanagawa") -- Replace this with your favorite colorscheme
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					italic = false,
					transparency = true,
          bold = false,
				},
			})
		end,
	},

	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- force no italic
				no_bold = false, -- force no bold
				no_underline = false, -- force no underline
				styles = { -- handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = { "italic" },
					keywords = { "italic" },
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
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Gruvbox Theme
	--
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			--  opts = ...,
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
			-- vim.cmd("colorscheme gruvbox")
			ColorMyPencils()
		end,
	},

	-- Monokai pro theme

	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				transparent_background = true,
				terminal_colors = true,
				devicons = true, -- highlight the icons of `nvim-web-devicons`
				styles = {
					comment = { italic = true },
					keyword = { italic = true }, -- any other keyword
					type = { italic = true }, -- (preferred) int, long, char, etc
					storageclass = { italic = true }, -- static, register, volatile, etc
					structure = { italic = true }, -- struct, union, enum, etc
					parameter = { italic = true }, -- parameter pass in function
					annotation = { italic = true },
					tag_attribute = { italic = true }, -- attribute of tag in reactjs
				},
				filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
				-- Enable this will disable filter option
				day_night = {
					enable = false, -- turn off by default
					day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
					night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				},
				inc_search = "background", -- underline | background
				background_clear = {
					-- "float_win",
					"toggleterm",
					"telescope",
					-- "which-key",
					"renamer",
					"notify",
					-- "nvim-tree",
					-- "neo-tree",
					-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
				}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
				plugins = {
					bufferline = {
						underline_selected = false,
						underline_visible = false,
					},
					indent_blankline = {
						context_highlight = "default", -- default | pro
						context_start_underline = false,
					},
				},
			})
		end,
	},
}
