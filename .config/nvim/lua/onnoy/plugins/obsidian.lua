return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("obsidian").setup({
			ui = { enable = false },
			workspaces = {
				{
					name = "Notes",
					path = "/home/wd/obsidian/2 - Main Notes/",
				},
			},
			templates = {
				folder = "~/obsidian/3 - Templates/",
				date_format = "%e %B - %Y",
				time_format = "%I:%M %p",
			},
		})
	end,
}
