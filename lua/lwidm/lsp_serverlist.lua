-- lua/lwidm/lsp_serverlist.lua

local M = {}

-- table id: server name
-- index 0: Mason name
-- index 1: options list
M.lsp_servers = {
	clangd = { "clangd", {} }, -- c, cpp
	codelldb = { "codelldb", {} }, -- c, cpp debugger
	rust_analyzer = { "rust_analyzer", {} }, -- rust
	-- lua_ls = { "lua-language-server", {} }, -- lua
	lua_ls = { "lua-language-server", {
		settings = { Lua = { diagnostics = { globals = { "vim" } } } },
	} }, -- lua
	cmake = { "cmake-language-server", {} }, -- cmake
	pyright = { "pyright", {} }, -- python
	debugpy = { "debugpy", {} }, -- python debugging
	-- jsonls = {}, -- json
	-- web
	html = { "html-lsp", {} }, -- html
	cssls = { "css-lsp", {} }, -- css
	ts_ls = { "typescript-language-server", {} }, -- javascript, typescript
	tailwindcss = { "tailwindcss-language-server", {} }, -- tailwindcss
	eslint = { "eslint-lsp", {} }, -- ESlint
	prettierd = { "prettierd", {} }, -- Prettier as a daemon
	-- intelephense = {}, -- php
	texlab = { "texlab", {} },
	ltex = { "ltex-ls", {} },
}
-- index 0: Mason name
-- index 1: Conform name
M.format_servers = {
	lua = { { "stylua", "stylua" } }, -- lua
	cpp = { { "clang-format", "clang-format" } }, -- c and c++
	python = { { "black", "black" } }, -- python
	cmake = { { "cmakelang", "cmake_format" } }, -- cmake
}

M.other_lsp_tools = {
	"mypy", -- python: static typing
	"ruff", -- python: linter and formatter
}

if vim.g.os_name == "Linux" then
	M.lsp_servers = vim.tbl_deep_extend("error", M.lsp_servers, {
		nil_ls = { "nil", {} }, -- nix
	})
	M.format_servers = vim.tbl_deep_extend("error", M.format_servers, {
		nix = { { "nixfmt", "nixfmt" }, { "nixpkgs-fmt", "nixpkgs-fmt" } }, -- nix
	})
end
-- function to convert the format_servers table to its mason or conform version
function M.transform_format_servers(format_servers, mason_table)
	local transformed = {}
	for lang, formatters in pairs(format_servers) do
		transformed[lang] = {}
		for _, formatter_pair in ipairs(formatters) do
			if mason_table then
				table.insert(transformed[lang], formatter_pair[1])
			else
				table.insert(transformed[lang], formatter_pair[2])
			end
		end
	end
	return transformed
end

M.ensure_installed = {}
for key, _ in pairs(M.lsp_servers) do
	table.insert(M.ensure_installed, key)
end
for _, values in pairs(M.transform_format_servers(M.format_servers, true)) do
	for _, value in ipairs(values) do
		table.insert(M.ensure_installed, value)
	end
end
for _, value in ipairs(M.other_lsp_tools) do
	table.insert(M.ensure_installed, value)
end

return M
