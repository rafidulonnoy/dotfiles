return {
	-- Preview markdown live in web browser
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreviewStop", "MarkdownPreview"  },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
