-- lua/lwidm/plugins/matlab.lua

local enabled = true
local plugin = {
	{
		"Rahlir/nvim-matlab",
		config = function()
			local matlab_path
			if vim.g.os_name == "Windows" then
				matlab_path = os.getenv("PROGRAMFILES"):gsub("\\", "/") .. "/MATLAB/R2023a/bin"
			else
				matlab_path = "matlab"
			end
			require("matlab").setup({

				-- Path to the matlab executable. If `matlab` is already in your $PATH, just leave this.
				matlab_path = matlab_path,

				-- How to open the matlab window. There are 4 options for now:
				-- split
				-- splitdown
				-- vsplit
				-- vsplitright
				open_window = require("matlab.openers").vsplit,

				-- Display the matlab splash screen on startup
				splash = true,

				-- A list of any other flags you want to add, when launching matlab
				matlab_flags = {},
			})
		end,
		keys = {
		-- stylua: ignore start
			{ "<leader>ms", function() require"matlab".evaluate("<matlab_cmd>") end, mode = "n", desc = "[M]atlab evaluate [S]tring", },
			{ "<leader>mc", function() require"matlab".evaluate("clear") end, mode = "n", silent = true, desc = "[M]atlab [C]lear", },
			{ "<leader>mr", function() require"matlab".evaluate_current_file() end, mode = "n", silent = true, desc = "[M]atlab [R]un (evaluate current file)", },
			{ "<leader>mb", function() require"matlab".evaluate_block() end, mode = "n", silent = true, desc = "[M]atlab evaluate [B]lock)", },
			{ "<leader>mv", function() require"matlab".evaluate_visual() end, mode = "v", silent = true, desc = "[M]atlab evaluate [V]isual)", },
			{ "<leader>mf", [[:lua require"matlab".evaluate_file(vim.fn.input('Enter file: path: '))<CR]], mode = "n", desc = "[M]atlab evaluate [F]ile", },
			{ "<leader>md", function() require"matlab".open_documentation_at_cursor() end, mode = "n", silent = true, desc = "[M]atlab open [D]ocumentation at cursor", },
			{ "<leader>mD", ":MatlabDoc", mode = "n", desc = "[M]atlab [D]ocumenation", },
			{ "<leader>me", function() require"matlab".close() end, mode = "v", silent = true, desc = "[M]atlab [E]xit", },
			{ "<leader>mo", function() require"matlab".open_workspace() end, mode = "v", silent = true, desc = "[M]atalb [O]pen workspace", },
			-- stylua: ignore end
		},
	},
	-- {
	-- 	"BalderHolst/matlab.nvim",
	-- 	config = function()
	-- 		local matlab_path
	-- 		if vim.g.os_name == "Windows" then
	-- 			matlab_path = os.getenv("PROGRAMFILES"):gsub("\\", "/") .. "/MATLAB/R2023a/bin"
	-- 		else
	-- 			matlab_path = "matlab"
	-- 		end
	-- 		require("matlab").setup({
	--
	-- 			-- Path to the matlab executable. If `matlab` is already in your $PATH, just leave this.
	-- 			matlab_path = matlab_path,
	--
	-- 			-- How to open the matlab window. There are 4 options for now:
	-- 			-- split
	-- 			-- splitdown
	-- 			-- vsplit
	-- 			-- vsplitright
	-- 			open_window = require("matlab.openers").vsplit,
	--
	-- 			-- Display the matlab splash screen on startup
	-- 			splash = true,
	--
	-- 			-- A list of any other flags you want to add, when launching matlab
	-- 			matlab_flags = {},
	-- 		})
	-- 	end,
	-- 	keys = {
	-- 	-- stylua: ignore start
	-- 		{ "<leader>ms", function() require"matlab".evaluate("<matlab_cmd>") end, mode = "n", desc = "[M]atlab evaluate [S]tring", },
	-- 		{ "<leader>mc", function() require"matlab".evaluate("clear") end, mode = "n", silent = true, desc = "[M]atlab [C]lear", },
	-- 		{ "<leader>mr", function() require"matlab".evaluate_current_file() end, mode = "n", silent = true, desc = "[M]atlab [R]un (evaluate current file)", },
	-- 		{ "<leader>mb", function() require"matlab".evaluate_block() end, mode = "n", silent = true, desc = "[M]atlab evaluate [B]lock)", },
	-- 		{ "<leader>mv", function() require"matlab".evaluate_visual() end, mode = "v", silent = true, desc = "[M]atlab evaluate [V]isual)", },
	-- 		{ "<leader>mf", [[:lua require"matlab".evaluate_file(vim.fn.input('Enter file: path: '))<CR]], mode = "n", desc = "[M]atlab evaluate [F]ile", },
	-- 		{ "<leader>md", function() require"matlab".open_documentation_at_cursor() end, mode = "n", silent = true, desc = "[M]atlab open [D]ocumentation at cursor", },
	-- 		{ "<leader>mD", ":MatlabDoc", mode = "n", desc = "[M]atlab [D]ocumenation", },
	-- 		{ "<leader>me", function() require"matlab".close() end, mode = "v", silent = true, desc = "[M]atlab [E]xit", },
	-- 		{ "<leader>mo", function() require"matlab".open_workspace() end, mode = "v", silent = true, desc = "[M]atalb [O]pen workspace", },
	-- 		-- stylua: ignore end
	-- 	},
	-- },
}
if enabled then
	return plugin
else
	return {}
end
