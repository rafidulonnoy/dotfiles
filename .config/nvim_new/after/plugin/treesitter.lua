require('nvim-treesitter.configs').setup {
    ensure_installed = { 'vim', 'vimdoc', 'c', 'lua', 'cpp' , 'javascript', 'typescript'},

	sync_install = false,

    auto_install = true,

    highlight = { enable = true },

    indent = { enable = true },
}
