-- lua/lwidm/helpers.lua

local M = {}

function M.tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\r\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\r\n'
		elseif type(v) == "table" then
			toprint = toprint .. M.tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

function M.create_floating_window(opts)
	opts = opts or {}

	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.width or math.floor(vim.o.lines * 0.5)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		-- border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
		border = "rounded",
		title = opts.title or "",
		title_pos = "center",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

return M
