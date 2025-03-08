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
			disable_frontmatter = true,
			workspaces = {
				{
					name = "Notes",
					path = "~/obsidian/2-MainNotes/",
				},
			},
			templates = {
				folder = "~/obsidian/99-Templates/",
				date_format = "%e %B - %Y",
				time_format = "%I:%M %p",
			},
		})
	end,
}
