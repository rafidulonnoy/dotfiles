return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			padding = true, -- Add space between comment and line
			sticky = true, -- Whether the cursor should stay at its position
			ignore = function()
				return "false"
			end, -- Avoid ignore warnings

			toggler = {
				line = "<leader>/", -- Change line-comment toggle keymap to <leader>/
				block = "gbc", -- Keep block-comment toggle keymap as is (or change if needed)
			},
			opleader = {
				line = "<leader>/", -- Change line-comment keymap in visual mode to <leader>/
				block = "gb", -- Keep block-comment keymap in visual mode as is (or change if needed)
			},
			extra = {
				above = "gcO", -- Add comment on the line above
				below = "gco", -- Add comment on the line below
				eol = "gcA", -- Add comment at the end of line
			},
			mappings = {
				basic = true, -- Basic key mappings (`gcc`, `gbc`)
				extra = true, -- Extra key mappings (`gco`, `gcO`, `gcA`)
			},
			pre_hook = ts_context_commentstring.create_pre_hook(), -- Required for TSX, JSX, etc.
			post_hook = function() end, -- Optional post hook if needed
		})
	end,
}

