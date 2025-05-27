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

	-- Helper function to calculate text color contrast
	local function get_contrast_color(hex)
		-- Convert hex to RGB
		local r = tonumber(hex:sub(2, 3), 16)
		local g = tonumber(hex:sub(4, 5), 16)
		local b = tonumber(hex:sub(6, 7), 16)

		-- Calculate relative luminance (WCAG formula)
		local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255

		-- Return dark or light text based on luminance
		return luminance > 0.5 and "#2E2E2E" or "#F8F8F2"
	end

	for group, cfg in pairs(highlights) do
		local fg_color = get_contrast_color(cfg.color)

		vim.api.nvim_set_hl(0, group, {
			underline = true,
			sp = cfg.color, -- Undercurl color
			bg = cfg.color, -- Background color
			fg = fg_color, -- Auto-contrast text
			blend = 20, -- 80% transparency
		})
	end
end

return M
