-- lua/lwidm/auto_update.lua

local function update_config()
	local config_path = vim.fn.stdpath("config")
	local git_status_cmd = "cd " .. config_path .. " && git status --porcelain"
	local git_pull_cmd = "cd " .. config_path .. " && git pull"

	-- Check for unstaged changes
	local handle = io.popen(git_status_cmd)
	if handle then
		local git_status_result = handle:read("*a")
		handle:close()
		if git_status_result ~= "" then
			print("There are unstaged changes. Config didn't autoupdate.")
			return
		end
	else
		print("Failed to execute git status command.")
		return
	end

	-- Pull latest changes if no unstaged changes
	handle = io.popen(git_pull_cmd)
	if handle then
		local git_pull_result = handle:read("*a")
		handle:close()
		print(git_pull_result)
	else
		print("Failed to execute git pull command")
	end
end

return update_config
