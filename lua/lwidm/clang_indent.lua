-- lua/lwidm/clang_indent.lua
-- Module: read .clang-format (or _clang-format) and set buffer-local indent options

local M = {}

-- Helper: search upward for a file (returns full path or nil)
local function find_upward(startpath, name)
	local start = startpath ~= nil and startpath or ""
	local bufname = vim.api.nvim_buf_get_name(0)
	local dir = vim.fn.fnamemodify(start ~= "" and start or bufname, ":p:h")
	if dir == "" or dir == "." then
		dir = vim.loop.cwd()
	end

	while dir and dir ~= "/" and dir ~= "." and dir ~= "" do
		local candidate = dir .. "/" .. name
		if vim.fn.filereadable(candidate) == 1 then
			return candidate
		end
		local parent = vim.fn.fnamemodify(dir, ":h")
		if parent == dir then
			break
		end
		dir = parent
	end

	return nil
end

-- Simple YAML-ish parser for .clang-format (finds IndentWidth and UseTab)
local function parse_clang_format(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local content = f:read("*a")
	f:close()
	local indent = content:match("^[ \t]*IndentWidth:%s*(%d+)")
	local use_tab = content:match("^[ \t]*UseTab:%s*([A-Za-z]+)")
	return { indent_width = indent and tonumber(indent) or nil, use_tab = use_tab }
end

-- Apply indent settings buffer-locally
function M.apply_indent_from_clang_format(bufnr, filepath)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	filepath = filepath and filepath or vim.api.nvim_buf_get_name(bufnr)
	if filepath == "" then
		filepath = vim.loop.cwd()
	end

	-- Try to find .clang-format or _clang-format
	local cfg = find_upward(filepath, ".clang-format") or find_upward(filepath, "_clang-format")
	if cfg then
		local parsed = parse_clang_format(cfg)
		if parsed and parsed.indent_width then
			vim.api.nvim_buf_set_option(bufnr, "shiftwidth", parsed.indent_width)
			vim.api.nvim_buf_set_option(bufnr, "tabstop", parsed.indent_width)
			vim.api.nvim_buf_set_option(bufnr, "softtabstop", parsed.indent_width)
			if parsed.use_tab then
				-- UseTab can be Never / ForIndentation / Always
				-- Treat "Never" => expandtab = true, otherwise use real tabs (expandtab = false)
				vim.api.nvim_buf_set_option(bufnr, "expandtab", parsed.use_tab:lower() == "never")
			end
		end
		return
	end

	-- Fallback: ask clang-format to dump the effective config (if available)
	if vim.fn.executable("clang-format") == 1 then
		local cmd = "clang-format -style=file -assume-filename=" .. vim.fn.shellescape(filepath) .. " -dump-config"
		local out = vim.fn.systemlist(cmd)
		if vim.v.shell_error == 0 and out then
			local outstr = table.concat(out, "\n")
			local indent = outstr:match("[Ii]ndentWidth:%s*(%d+)")
			local use_tab = outstr:match("[Uu]seTab:%s*([A-Za-z]+)")
			if indent then
				local n = tonumber(indent)
				vim.api.nvim_buf_set_option(bufnr, "shiftwidth", n)
				vim.api.nvim_buf_set_option(bufnr, "tabstop", n)
				vim.api.nvim_buf_set_option(bufnr, "softtabstop", n)
				if use_tab then
					vim.api.nvim_buf_set_option(bufnr, "expandtab", use_tab:lower() == "never")
				end
			end
		end
	end
end

-- Setup: create autocmds for C/C++ file patterns
function M.setup(opts)
	opts = opts or {}
	local patterns = opts.patterns
		or { "*.c", "*.h", "*.cpp", "*.cc", "*.cxx", "*.hpp", "*.hh", "*.cc", "*.c++", "*.hxx" }

	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		pattern = patterns,
		callback = function(args)
			M.apply_indent_from_clang_format(args.buf, args.file)
		end,
	})
end

return M
