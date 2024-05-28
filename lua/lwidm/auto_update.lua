-- lua/lwidm/auto_update.lua
local Job = require("plenary.job")

local function notify(message, level)
	vim.notify(message, level)
end

local function run_git_command(args, success_message, failure_message)
	Job:new({
		command = "git",
		args = args,
		cwd = vim.fn.stdpath("config"),
		on_exit = function(_, return_val)
			if return_val == 0 then
				notify(success_message, vim.log.levels.INFO)
			else
				notify(failure_message, vim.log.levels.ERROR)
			end
		end,
	}):start()
end

local function is_nvim_config_clean()
	local result = Job:new({
		command = "git",
		args = { "status", "--porcelain" },
		cwd = vim.fn.stdpath("config"),
	}):sync()
	return #result == 0
end

local function git_pull_nvim_config()
	run_git_command({ "pull", "origin", "main" }, "Successfully pulled the latest changes.", "Failed to pull changes.")
end

local function git_push_nvim_config()
	run_git_command({ "push", "origin", "main" }, "Successfully pushed the latest changes.", "Failed to push changes.")
end

local function update_nvim_config()
	if is_nvim_config_clean() then
		git_pull_nvim_config()
		git_push_nvim_config()
	else
		notify(
			"Couldn't update neovim config. Unstaged or untracked files present. Commit your changes first.",
			vim.log.levels.WARN
		)
	end
end

vim.api.nvim_create_user_command("UpdateNvimConfig", update_nvim_config, {})
