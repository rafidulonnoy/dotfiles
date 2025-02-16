return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				svelte = { "prettier" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				graphql = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				erb = { "htmlbeautifier" },
				html = { "htmlbeautifier" },
				bash = { "beautysh" },
				yaml = { "yamlfix" },
				toml = { "taplo" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				sh = { "shellcheck" },
				go = { "gofmt" },
        python = {"black"}
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 1000,
			-- },
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
