-- lua/lwidm/plugins/yuck.lua

local enabled = true
local plugin = {
	-- vim filetype support for the new eww configuration language yuck
	"elkowar/yuck.vim",
}
if enabled then
	return plugin
else
	return {}
end
