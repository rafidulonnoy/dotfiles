return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers",
			-- separator_style = { "|", "|" },
			--numbers = "buffer_id",
		},
		highlights = {
			separator_selected = {
				fg = "#393552", -- Rose Pine Moon "highlight" color
				bg = "#2a283d",
			},
		},
	},
}
