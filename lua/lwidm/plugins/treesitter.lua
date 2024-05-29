-- lua/lwidm/plugins/treesitter.lua

local enabled = true
local plugin = {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "python", "bash", "html", "markdown", "vim", "vimdoc", "c", "cpp", "lua" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end
