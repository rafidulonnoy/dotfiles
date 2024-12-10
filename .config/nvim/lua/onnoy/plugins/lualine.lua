return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				component_separators = "|",
				section_separators = "",
			},
			extension = { "quichfix" },
			sections = {
				lualine_a = {
					-- {
					-- 	"buffers",
					-- 	icons_enabled = true,
					-- 	symbols = {
					-- 		modified = " ●", -- Text to show when the buffer is modified
					-- 		alternate_file = "", -- Text to show to identify the alternate file
					-- 		directory = "", -- Text to show when the buffer is a directory
					-- 	},
     --        use_mode_colors = true,
					-- },
          {"filename"},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {
					-- {
					-- 	lazy_status.updates,
					-- 	cond = lazy_status.has_updates,
					-- 	color = { fg = "#ff9e64" },
					-- },

					{
						"branch",
						icon = { "",  color = { fg = "green" } },
					},
					{
						"diff",
						colored = true, -- Displays a colored diff status if set to true
						diff_color = {
							-- Same color values as the general color option can be used here.
							added = "LuaLineDiffAdd", -- Changes the diff's added color
							modified = "LuaLineDiffChange", -- Changes the diff's modified color
							removed = "LuaLineDiffDelete", -- Changes the diff's removed color you
						},
						symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
						source = nil, -- A function that works as a data source for diff.
						-- It must return a table as such:
						--   { added = add_count, modified = modified_count, removed = removed_count }
						-- or nil on failure. count <= 0 won't be displayed.
					},
					{ "diagnostics" },
					{ "filetype" },
				},
			},
		})
	end,
}
