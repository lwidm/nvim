-- lua/lwidm/get_os_name.lua

local function get_os_name()
	local uname = vim.loop.os_uname()
	local os_name = uname.sysname
	if os_name == "Darwin" then
		os_name = "Mac"
	elseif os_name == "Linux" then
		os_name = "Linux"
	elseif os_name == "Windows_NT" then
		os_name = "Windows"
	else
		os_name = "Unknown"
	end
	return os_name
end

return get_os_name
