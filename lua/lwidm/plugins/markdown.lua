-- lua/lwidm/plugins/markdown.lua

local enabled = true
local plugin = {
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			-- stylua: ignore start
			{ "<leader>mp", ":MarkdownPreviewToggle<CR>", mode = "n", silent = true, desc = "[M]arkdown [P]review toggle"},
			-- stylua: ignore end
		},
	},

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
