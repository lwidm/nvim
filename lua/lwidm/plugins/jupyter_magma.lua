-- lua/lwidm/plugins/jupyter_magma.lua

local enabled = false
local plugin = {
	{
		"dccsillag/magma-nvim",
		config = function()
			vim.g.magma_automatically_open_output = false
			-- vim.g.magma_image_provider = "ueberzug"
		end,
	},
	options = {
		vim.keymap.set(
			"n",
			"<localleader>r",
			"<CMD>MagmaEvaluateOperator<CR>",
			{ desc = "Magma evaluate operator (jupyter)" }
		),
		vim.keymap.set(
			"n",
			"<localleader>rr",
			"<CMD>MagmaEvaluateLine<CR>",
			{ desc = "Magma evaluate line (jupyter)" }
		),
		vim.keymap.set(
			"n",
			"<localleader>rc",
			"<CMD>MagmaReevaluateCell<CR>",
			{ desc = "Magma evaluate cell (jupyter)" }
		),
		vim.keymap.set("n", "<localleader>rd", "<CMD>MagmaDelete<CR>", { desc = "Magma Delete (jupyter)" }),
		vim.keymap.set("n", "<localleader>ro", "<CMD>MagmaShowOutput<CR>", { desc = "Magma show output (jupyter)" }),
		vim.keymap.set("n", "<localleader>rip", function()
			vim.cmd([[
                :MagmaInit python3
                :MagmaEvaluateArgument a=5
            ]])
		end, { desc = "Magama init python3" }),
	},
}
if enabled then
	return plugin
else
	return {}
end
