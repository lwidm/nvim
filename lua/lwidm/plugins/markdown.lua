-- lua/lwidm/plugins/markdown.lua

local enabled = true
local plugin = {

	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>mp", "<cmd>Markview<cr>", desc = "[M]arkdown [P]review toggle" },
		},
	},

	-- install without yarn or npm
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	ft = { "markdown" },
	-- 	build = function()
	-- 		vim.fn["mkdp#util#install"]()
	-- 	end,
	-- 	keys = {
	-- 		-- stylua: ignore start
	-- 		{ "<leader>mp", ":MarkdownPreviewToggle<CR>", mode = "n", silent = true, desc = "[M]arkdown [P]review toggle"},
	-- 		-- stylua: ignore end
	-- 	},
	-- },

	-- install with yarn or npm
	-- {
	--   "iamcco/markdown-preview.nvim",
	--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	--   build = "cd app && yarn install",
	--   init = function()
	--     vim.g.mkdp_filetypes = { "markdown" }
	--   end,
	--   ft = { "markdown" },
	-- },
}
if enabled then
	return plugin
else
	return {}
end
