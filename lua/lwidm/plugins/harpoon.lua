return {
	-- harpoon
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon.mark").add_file()
				end,
				mode = "n",
				desc = "[A]dd file to harpoon",
			},
			{
				"<C-e>",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				mode = "n",
				desc = "Toggle harpoon quick menu",
			},
			{
				"<C-h>",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				mode = "n",
				desc = "navigate to 1st file in harpoon",
			},
			{
				"<C-t>",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				mode = "n",
				desc = "navigate to 2nd file in harpoon",
			},
			{
				"<C-n>",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				mode = "n",
				desc = "navigate to 3rd file in harpoon",
			},
			{
				"<C-s>",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				mode = "n",
				desc = "navigate to 4th file in harpoon",
			},
		},
	},
}
