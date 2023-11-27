-- leader
vim.g.mapleader = " "

-- encode
vim.o.encoding = "utf-8"
vim.o.emoji = true

-- format
vim.o.colorcolumn = "81"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.cinoptions = vim.o.cinoptions .. ":0"

-- util
vim.o.background = "light"
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.backspace = "indent,eol,start"

-- search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true

-- file
vim.o.number = true
vim.o.title = true
vim.o.wrap = true
vim.o.breakindent = true
vim.o.textwidth = 80
vim.o.foldenable = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = "nosplit"
vim.o.laststatus = 2

-- performance
vim.o.history = 1000
vim.o.undofile = true
vim.o.swapfile = true
vim.o.lazyredraw = true
vim.o.redrawtime = 10000
vim.o.showmode = false
vim.o.showcmd = false
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.o.scrolljump = 5
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.cmdheight = 1
vim.o.updatetime = 300
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.signcolumn = "number"

vim.keymap.set("i", "jj", "<Esc>l", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bl", ":buffers<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { noremap = true, silent = true })

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		-- NORMAL MODE BASIC
		-- `gcc` - Toggles the current line using linewise comment
		-- `gbc` - Toggles the current line using blockwise comment
		-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
		-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
		-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
		-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

		-- VISUAL MODE
		-- `gc` - Toggles the region using linewise comment
		-- `gb` - Toggles the region using blockwise comment

		-- NORMAL MODE EXTRA
		-- `gco` - Insert comment to the next line and enters INSERT mode
		-- `gcO` - Insert comment to the previous line and enters INSERT mode
		-- `gcA` - Insert comment to end of the current line and enters INSERT mode

		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"frazrepo/vim-rainbow",
		config = function()
			vim.g.rainbow_active = 1
		end,
	})

	-- use({
	-- 	"shaunsingh/solarized.nvim",
	-- 	config = function()
	-- 		require("solarized").set()
	-- 	end,
	-- })

	use({
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({ options = { theme = "auto" } })
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({ open_mapping = "<A-t>", direction = "float" })
		end,
	})

	use({
		"mawkler/modicator.nvim",
		config = function()
			vim.o.number = true
			require("modicator").setup()
		end,
	})

	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil, -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
				performance_mode = false, -- Disable "Performance Mode" on all buffers.
			})
		end,
	})

	use({
		"kdheepak/tabline.nvim",
		requires = { { "nvim-lualine/lualine.nvim", opt = true }, { "kyazdani42/nvim-web-devicons", opt = true } },
		config = function()
			require("tabline").setup()
			vim.keymap.set("n", "<M-o>", ":TablineBufferNext<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<M-p>", ":TablineBufferPrevious<CR>", { noremap = true, silent = true })
		end,
	})

	use({
		"sbdchd/neoformat",
		config = function()
			vim.keymap.set("n", "<leader>f", ":Neoformat<CR>", kb_opts)
		end,
	})

	use({
		"ibhagwan/fzf-lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				fzf_colors = {
					["bg+"] = { "bg", "CursorLine" },
					["fg+"] = { "fg", "Normal" },
					["gutter"] = { "bg", "Normal" },
				},
			})
			vim.keymap.set("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
			vim.keymap.set("n", "<C-g>", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
			vim.keymap.set("n", "<C-/>", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", { silent = true })
		end,
	})

	use({
		"tpope/vim-fugitive",
	})

	use({
		"mrjones2014/smart-splits.nvim",
		config = function()
			vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

			vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
			vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
			vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
			vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
		end,
	})

	use({
		"preservim/tagbar",
		config = function()
			vim.keymap.set("n", "<C-t>", ":TagbarToggle<CR>")
		end,
	})

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
