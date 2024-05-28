-- lua/lwidm/auto_update.lua

local Job = require("plenary.job")

local function run_git_command(args)
	local success = false
	local job = Job:new({
		command = "git",
		args = args,
		cwd = vim.fn.stdpath("config"),
		on_exit = function(j, return_val)
			success = return_val
		end,
	})
	job:sync()
	return (success == 0)
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
	return run_git_command({ "pull", "origin", "main" })
end

local function git_push_nvim_config()
	return run_git_command({ "push", "origin", "main" })
end

local function update_nvim_config()
	if is_nvim_config_clean() then
		if git_pull_nvim_config() then
			vim.notify("Successfully pulled the latest changes.", vim.log.levels.INFO)
			if git_push_nvim_config() then
				vim.notify("Successfully pushed the latest changes.", vim.log.levels.INFO)
			else
				vim.notifiy("Failed to push changes.", vim.log.levels.ERROR)
			end
		else
			vim.notify("Failed to pull changes.", vim.log.levels.ERROR)
		end
	else
		vim.notify(
			"Couldn't update neovim config. Unstaged or untracked files present. Commit your changes first.",
			vim.log.levels.WARN
		)
	end
end

vim.api.nvim_create_user_command("UpdateNvimConfig", update_nvim_config, {})

return update_nvim_config
