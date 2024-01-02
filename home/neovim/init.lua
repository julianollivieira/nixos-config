-- init lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

lazy.setup({
  { "nvim-lua/plenary.nvim", version = "0.1.4" },
  { "kyazdani42/nvim-web-devicons", version = "0.1.4" },
  { "nvim-lua/telescope.nvim", version = "0.1.5" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
  { "https://gitlab.com/yorickpeterse/nvim-window.git", lazy = false },
  { "numToStr/Comment.nvim", lazy = false },
  { "rebelot/kanagawa.nvim" }
})

-- configure basic vim settings
vim.g.mapleader = " "           -- Set leader to <space>
vim.cmd.colorscheme("kanagawa") -- Set the colorscheme
vim.cmd.set("mouse=")           -- Disable the mouse
vim.cmd.set("number")           -- Enable line numbering
vim.cmd.set("relativenumber")   -- Enable relative line numbering
vim.cmd.set("tabstop=2")        -- Set number of spaces for a tab
vim.cmd.set("shiftwidth=2")     -- Set number of spaces for a line shift
vim.cmd.set("cursorline")       -- Highlight the line the cursor in on
vim.cmd.set("termguicolors")    -- Enable termguicolors

-- mappings
vim.api.nvim_set_keymap("n", "<leader>w", ":lua require('nvim-window').pick()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>1", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>e", ":lua require('harpoon.mark').add_file()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><tab>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope grep_string<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true })
