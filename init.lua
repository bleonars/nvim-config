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
vim.o.termguicolors = false
vim.cmd([[colorscheme vim]])
vim.o.mouse = "a"
vim.o.backspace = "indent,eol,start"

-- clipboard
vim.o.clipboard = "unnamedplus"

local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}

-- search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false

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
vim.o.history = 10
vim.o.undofile = false
vim.o.swapfile = false
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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {

		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
				vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
				vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
				vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope help tags" })
			end,
		},

		{
			"nvim-neo-tree/neo-tree.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons",
			},
		},

		{
			"sbdchd/neoformat",
			config = function()
				vim.keymap.set("n", "<leader>nf", ":Neoformat<CR>", kb_opts)
			end,
		},

		{
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
		},

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("lualine").setup()
			end,
		},

		{
			"kdheepak/tabline.nvim",
			dependencies = { "nvim-lualine/lualine.nvim", "nvim-tree/nvim-web-devicons" },
			config = function()
				require("tabline").setup()
				vim.keymap.set("n", "<M-o>", ":TablineBufferNext<CR>", { noremap = true, silent = true })
				vim.keymap.set("n", "<M-p>", ":TablineBufferPrevious<CR>", { noremap = true, silent = true })
			end,
		},

		{
			"preservim/tagbar",
			config = function()
				vim.keymap.set("n", "<C-t>", ":TagbarToggle<CR>")
			end,
		},

		{
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
		},

		{
			"tpope/vim-fugitive",
		},
	},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "vim" } },

	-- automatically check for plugin updates
	checker = { enabled = true },
})
