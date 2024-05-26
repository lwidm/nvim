-- lua/lwidm/auto_update.lua

local function git_push(git_push_cmd)
	local handle = io.popen(git_push_cmd)
	if handle then
		local git_push_result = handle:read("*a")
		handle:close()

		if git_push_result ~= nil then
			print(git_push_result)
		else
			error("Error occurred while pushing changes.")
		end
	else
		error("failed to execute git push command")
	end
end

local function git_sync(git_pull_cmd, git_push_cmd)
	local handle = io.popen(git_pull_cmd)
	if handle then
		local git_pull_result = handle:read("*a")
		handle:close()
		print(git_pull_result)

		if git_pull_result ~= nil then
			print(git_pull_result)

			-- Push changes
			git_push(git_push_cmd)
		else
			error("Error occurred while pulling latest changes.")
		end
	else
		error("Failed to execute git pull command")
	end
end

local function git_check_unstaged_untracked(git_status_cmd)
	local handle = io.popen(git_status_cmd)
	if handle then
		local git_status_result = handle:read("*a")
		handle:close()
		if git_status_result ~= "" then
			print("There are unstaged changes or untracked files. Config didn't autoupdate.")
			return false
		end
		return true
	else
		error("Failed to execute git status command.")
		return false
	end
end

local function update_config()
	local config_path = vim.fn.stdpath("config")
	local git_status_cmd = "cd " .. config_path .. " && git status --porcelain"
	local git_pull_cmd = "cd " .. config_path .. " && git pull"
	local git_push_cmd = "cd " .. config_path .. " && git push"

	-- Check for unstaged changes
	if not git_check_unstaged_untracked(git_status_cmd) then
		return
	end

	-- Sync with github repo if no unstaged changes or untracked files
	git_sync(git_pull_cmd, git_push_cmd)
end

return update_config
