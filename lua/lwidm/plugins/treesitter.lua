-- lua/lwidm/plugins/treesitter.lua

local enabled = true
local plugin = {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"python",
				"c",
				"cpp",
				"rust",
				"lua",
				"javascript",
				"typescript",
				"css",
				"html",
				"bash",
				"html",
				"markdown",
				"vim",
				"vimdoc",
				"nix",
				"fortran",
				"matlab",
			},
			ignore_install = { "latex" },
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "latex" },
				additional_vim_regex_highlighting = { "latex", "markdown" },
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
