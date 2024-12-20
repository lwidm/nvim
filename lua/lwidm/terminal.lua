-- lua/lwidm/terminal.lua

local helpers = require("lwidm.helpers")

if vim.g.os_name == "Windows" then
	vim.opt.shell = '"C:/Program Files/PowerShell/7/pwsh.exe"'
end

-- if you want to disable numbering in the terminal uncomment this
-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	group = vim.api.nvim_create_autocmd("custom-term-open", { clear = true }),
-- 	callback = function()
-- 		vim.opt.number = false
-- 		vim.bo.relativenumber = false
-- 	end,
-- })
local job_terminal_id = 0
vim.keymap.set("n", "<leader>ts", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
	job_terminal_id = vim.bo.channel
end, { desc = "Open [T]erminal [S]mall " })

local float_terminal_state = {
	floating = {
		buf = -1,
		win = -1,
		title = "Terminal",
	},
}
vim.keymap.set("n", "<leader>tf", function()
	if not vim.api.nvim_win_is_valid(float_terminal_state.floating.win) then
		float_terminal_state.floating = helpers.create_floating_window(float_terminal_state.floating)
		if vim.bo[float_terminal_state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
		vim.cmd("startinsert")
	else
		vim.api.nvim_win_hide(float_terminal_state.floating.win)
	end
end, { desc = "Open [T]erminal [F]loating" })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "close terminal" })

-- Chansend commands
local function check_build_dir()
	if vim.fn.isdirectory("build") == 1 then
		return true
	else
		vim.notify("Error: Build directory does not exist.", vim.log.levels.ERROR)
		return false
	end
end

local function check_cmake_lists()
	if vim.fn.filereadable("CMakeLists.txt") == 1 then
		return true
	else
		vim.notify("No CMakeLists.txt found in the current directory.", vim.log.levels.ERROR)
		return false
	end
end

vim.keymap.set("n", "<leader>tccd", function()
	if not check_cmake_lists() then
		return
	end
	if not check_build_dir() then
		vim.fn.mkdir("build")
	end
	vim.fn.chansend(job_terminal_id, { "cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug\r\n" })
end, { desc = "[T]erminal: [C]make [C]onfigure [D]ebug" })

vim.keymap.set("n", "<leader>tccr", function()
	if not check_cmake_lists() then
		return
	end
	if not check_build_dir() then
		vim.fn.mkdir("build")
	end
	vim.fn.chansend(job_terminal_id, { "cmake -S . -B build -DCMACE_BUILD_TYPE=Release\r\n" })
end, { desc = "[T]erminal: [C]make [C]onfigure [R]elease" })

vim.keymap.set("n", "<leader>tcbd", function()
	if not check_build_dir() then
		vim.fn.mkdir("build")
	end
	vim.fn.chansend(job_terminal_id, { "cmake --build build --config Debug\r\n" })
end, { desc = "[T]erminal: [C]make [B]uild [D]ebug" })

vim.keymap.set("n", "<leader>tcbr", function()
	if not check_build_dir() then
		vim.fn.mkdir("build")
	end
	vim.fn.chansend(job_terminal_id, { "cmake --build build --config Release\r\n" })
end, { desc = "[T]erminal: [C]make [B]uild [R]elease" })
