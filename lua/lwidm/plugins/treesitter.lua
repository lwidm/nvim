-- lua/lwidm/plugins/treesitter.lua

local enabled = true
local plugin = {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
				disable = { "latex" },
				additional_vim_regex_highlighting = { "latex", "markdown" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- require("nvim-treesitter.install").prefer_git = false
			if vim.g.os_name == "Windows" then
				require("nvim-treesitter.install").compilers = { "zig", "clang", "cl" }
			end
			vim.treesitter.language.register("cpp", "cuda")
			if pcall(require, "nvim-treesitter.configs") then
				---@diagnostic disable-next-line: missing-fields
				require("nvim-treesitter.configs").setup(opts)
			else
				-- New nvim-treesitter v1.0+ API: setup() only accepts install_dir;
				-- highlight must be enabled manually via autocmd
				local disable = (opts.highlight or {}).disable or {}
				vim.api.nvim_create_autocmd("FileType", {
					callback = function()
						if not vim.list_contains(disable, vim.bo.filetype) then
							pcall(vim.treesitter.start)
						end
					end,
				})
			end
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end
