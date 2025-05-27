-- lua/lwidm/wezterm.lua
local M = {}

function M.setup()
	if vim.fn.exists("$WEZTERM_PANE") ~= 1 then
		return
	end

	local escape = function(code)
		return vim.api.nvim_replace_termcodes(code, true, true, true)
	end

	local highlights = {
		SpellBad = { color = "#F38BA8" },
		SpellCap = { color = "#F9E2AF" },
		SpellLocal = { color = "#94E2D5" },
		SpellRare = { color = "#89B4FA" },
	}

	for group, cfg in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, {
			underline = true, -- will use t_Cs / t_Ce from above
			sp = cfg.color, -- underline color
			fg = nil, -- keep normal text color
			bg = nil, -- don't touch background
		})
	end
end

return M
