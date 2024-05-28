-- lua/lwidm/auto_update.lua

local function execute_command(command)
	local handle = io.popen(command)
	assert(handle, "Failed to execute command: " .. command)
	local result = handle:read("*a")
	handle:close()
	return result
end

local function git_check_unstaged_untracked(config_path)
	print("Checking status of local git repo ...")
	local git_status_cmd = "cd " .. config_path .. " && git status --porcelain"
	local status = execute_command(git_status_cmd)
	if status ~= "" then
		print("There are unstaged changes or untracked files. Config didn't autoupdate.")
		return false
	end
	return true
end

local function git_pull(config_path)
	print("Pulling from GitHub repo ...")
	local git_pull_cmd = "cd " .. config_path .. " && git pull"
	local pull_result = execute_command(git_pull_cmd)
	print(pull_result)
end

local function git_push(config_path)
	print("Pushing to GitHub repo ...")
	local git_push_cmd = "cd " .. config_path .. " && git push"
	local push_result = execute_command(git_push_cmd)
	print(push_result)
end

local function update_config()
	local config_path = vim.fn.stdpath("config")

	-- Check for unstaged changes
	if not git_check_unstaged_untracked(config_path) then
		return
	end

	-- Sync with github repo if no unstaged changes or untracked files
	git_pull(config_path)
	git_push(config_path)
	print("Config updated successfully.")
end

return update_config
