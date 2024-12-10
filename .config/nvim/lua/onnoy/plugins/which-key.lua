return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			["<leader>s"] = { name = "Split", _ = "which_key_ignore" },
			["<leader>c"] = { name = "Code actions", _ = "which_key_ignore" },
			["<leader>e"] = { name = "Toggle NvimTree", _ = "which_key_ignore" },
			["<leader>f"] = { name = "Find Anything", _ = "which_key_ignore" },
			["<leader>m"] = { name = "Format", _ = "which_key_ignore" },
			["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			["<leader>t"] = { name = "Tab options", _ = "which_key_ignore" },
		})
		-- visual mode
		require("which-key").register({
			["<leader>h"] = { "Git [H]unk" },
		}, { mode = "v" })
	end,
}
