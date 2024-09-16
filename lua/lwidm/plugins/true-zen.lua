-- lua/lwidm/plugins/true-zen.lua

local enabled = true
local plugin = {
	{
		"Pocco81/true-zen.nvim",
		config = function()
			require("true-zen").setup({})
		end,
		keys = {
			-- stylua: ignore start
			{ "<leader>zf", ":TZAtaraxis<CR>", mode = "n", desc = "[Z]en mode ([F]ocus)", },
			-- stylua: ignore end
		},
	},
}
if enabled then
	return plugin
else
	return {}
end
