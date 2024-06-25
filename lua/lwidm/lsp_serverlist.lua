-- lua/lwidm/lsp_serverlist.lua

local M = {}

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
	-- html = {}, -- html
	-- cssls = {}, -- css
	-- tsserver = {}, -- javascript, typescript
	-- intelephense = {}, -- php
}
M.format_servers = {
	lua = { "stylua" }, -- lua
	cpp = { "clang-format" }, -- c and c++
	python = { "black" }, -- python
	cmake = { "cmake-format" }, -- cmake
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
		nix = { "nixfmt", "nixpkgs-fmt" }, -- nix
	})
end

M.ensure_installed = {}
for key, _ in pairs(M.lsp_servers) do
	table.insert(M.ensure_installed, key)
end
for _, values in pairs(M.format_servers) do
	for _, value in ipairs(values) do
		table.insert(M.ensure_installed, value)
	end
end
for _, value in ipairs(M.other_lsp_tools) do
	table.insert(M.ensure_installed, value)
end

return M
