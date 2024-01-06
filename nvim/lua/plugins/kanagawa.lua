return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
	require("kanagawa").setup({
	    undercurl = true,
	    transparent = false,
	})

	vim.cmd.colorscheme("kanagawa-dragon")
    end
}
