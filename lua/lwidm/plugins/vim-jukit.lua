-- lua/lwidm/plugins/vim-jukit.lua

local enabled = false
local plugin = {
	{
		"luk400/vim-jukit",
		config = function()
			local map = vim.keymap.set

        		-- stylua: ignore start
        		-- Splits
        		map("n", "<localleader>jo", "<cmd>call jukit#splits#output()<cr>", { desc = "[O]pen output window and execute command" })
        		map("n", "<localleader>jst", "<cmd>call jukit#splits#term()<cr>", { desc = "[S]plit [T]erminal (Open empty output window" })
        		map("n", "<localleader>jhm", "<cmd>call jukit#splits#history()<cr>", { desc = "Open output[-][H]istory window" })
        		map("n", "<localleader>jhp", "<cmd>call jukit#splits#output_and_history()<cr>", { desc = "Open output[+][H]istory windows" })
        		map("n", "<localleader>jhd", "<cmd>call jukit#splits#close_history()<cr>", { desc = "Close [h]istory window" })
        		map("n", "<localleader>jha", "<cmd>call jukit#splits#toggle_auto_hist()<cr>", { desc = "Toggle [A]uto-[H]istory" })
        		map("n", "<localleader>jCc", "<cmd>call jukit#splits#close_output_split()<cr>", { desc = "[C]lose output window" })
        		map("n", "<localleader>jCC", "<cmd>call jukit#splits#close_output_and_history(1)<cr>", { desc = "[C]lose both windows" })
        		map("n", "<localleader>jso", "<cmd>call jukit#splits#show_last_cell_output(1)<cr>", { desc = "[S]how current cell [o]utput" })
        		map("n", "<localleader>jd", "<cmd>call jukit#splits#out_hist_scroll(1)<cr>", { desc = "Scroll history down" })
        		map("n", "<localleader>ju", "<cmd>call jukit#splits#out_hist_scroll(0)<cr>", { desc = "Scroll history up" })
        		map("n", "<localleader>jl", "<cmd>call jukit#layouts#set_layout()<cr>", { desc = "Apply [L]ayout to splits" })

        		-- Sending code
        		map("n", "<localleader>j<space>", "<cmd>call jukit#send#section(0)<cr>", { desc = "Send current cell" })
        		map("n", "<localleader>jsl", "<cmd>call jukit#send#line()<cr>", { desc = "[S]end current [L]ine" })
        		map("v", "<localleader>jsv", "<cmd>call jukit#send#selection()<cr>", { desc = "[S]end [V]isual selection" })
        		map("n", "<localleader>jec", "<cmd>call jukit#send#until_current_section()<cr>", { desc = "[E]xecute until [C]urrent cell" })
        		map("n", "<localleader>jea", "<cmd>call jukit#send#all()<cr>", { desc = "[E]xecute [A]ll cells" })

        		-- Cells
        		map("n", "<localleader>jco", "<cmd>call jukit#cells#create_below(0)<cr>", { desc = "Create [C]ell (code) below" })
        		map("n", "<localleader>jcO", "<cmd>call jukit#cells#create_above(0)<cr>", { desc = "Create [C]ell (code) above" })
        		map("n", "<localleader>jct", "<cmd>call jukit#cells#create_below(1)<cr>", { desc = "Create [C]ell ([T]ext) below" })
        		map("n", "<localleader>jcT", "<cmd>call jukit#cells#create_above(1)<cr>", { desc = "Create [C]ell ([T]ext) above" })
        		map("n", "<localleader>jcd", "<cmd>call jukit#cells#delete()<cr>", { desc = "Delete current cell" })
        		map("n", "<localleader>jcs", "<cmd>call jukit#cells#split()<cr>", { desc = "[C]ell [S]plit" })
        		map("n", "<localleader>jcM", "<cmd>call jukit#cells#merge_above()<cr>", { desc = "[C]ell [M]erge above" })
        		map("n", "<localleader>jcm", "<cmd>call jukit#cells#merge_below()<cr>", { desc = "[C]ell [M]erge blelow" })
        		map("n", "<localleader>jck", "<cmd>call jukit#cells#move_up()<cr>", { desc = "[C]ell [M]ove up" })
        		map("n", "<localleader>jcj", "<cmd>call jukit#cells#move_down()<cr>", { desc = "[C]ell [M]ove down" })
        		map("n", "<localleader>jJ", "<cmd>call jukit#cells#jump_to_next_cell()<cr>", { desc = "Jump to next cell" })
        		map("n", "<localleader>jK", "<cmd>call jukit#cells#jump_to_previous_cell()<cr>", { desc = "Jump to previous cell" })
        		map("n", "<localleader>jDc", "<cmd>call jukit#cells#delete_outputs(0)<cr>", { desc = "[D]elete [C]urrent cell output" })
        		map("n", "<localleader>jDa", "<cmd>call jukit#cells#delete_outputs(1)<cr>", { desc = "[D]elete [A]ll outputs" })

        		-- ipynb conversion
        		map("n", "<localleader>jnp", "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<cr>", { desc = "Convert ipynb/py" })
        		map("n", "<localleader>jHt", "<cmd>call jukit#convert#save_nb_to_file(0,1,'html')<cr>", { desc = "Convert to HTML" })
        		map("n", "<localleader>jHr", "<cmd>call jukit#convert#save_nb_to_file(1,1,'html')<cr>", { desc = "Convert to HTML ([R]e-run)" })
        		map("n", "<localleader>jPd", "<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>", { desc = "Convert to PDF" })
        		map("n", "<localleader>jPr", "<cmd>call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>", { desc = "Convert to PDF ([R]e-run)" })

			-- stylua: ignore end
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end
