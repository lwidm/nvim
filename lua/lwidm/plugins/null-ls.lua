-- lua/lwidm/plugins/null-ls.lua

local enabled = true
local plugin = {
	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			local sources = {}
			if vim.fn.executable("mypy") == 1 then
				table.insert(sources, null_ls.builtins.diagnostics.mypy)
			end
			if vim.fn.executable("ruff") == 1 then
				table.insert(sources, null_ls.builtins.diagnostics.ruff)
			end
			null_ls.setup({
				sources = sources,
			})
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end
