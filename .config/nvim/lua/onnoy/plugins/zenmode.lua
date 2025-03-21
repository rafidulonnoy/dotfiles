return {
	"folke/zen-mode.nvim",
	config = function()
		vim.keymap.set("n", "<leader>zz", function()
			require("zen-mode").setup({
				plugins = {
          twilight = {enabled = false},
          tmux = {enabled = false},
        },
				window = {
          backdrop = 0.95,
					width = 90,
					options = {},
				},
			})
			require("zen-mode").toggle()
			vim.wo.wrap = true
			vim.wo.number = true
			vim.wo.rnu = true
			ColorMyPencils()
		end)

		vim.keymap.set("n", "<leader>zZ", function()
			require("zen-mode").setup({
				window = {
					width = 80,
					options = {},
				},
			})
			require("zen-mode").toggle()
			vim.wo.wrap = true
			vim.wo.number = false
			vim.wo.rnu = false
			vim.opt.colorcolumn = "0"
			ColorMyPencils()
		end)
	end,
}
