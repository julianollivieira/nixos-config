require("core.lazy").setup({
  -- utility libs
  { "nvim-lua/plenary.nvim", version = "0.1.4" },
  { "kyazdani42/nvim-web-devicons", version = "0.1.4" },
  { "onsails/lspkind.nvim" },

  -- navigation
  { "https://gitlab.com/yorickpeterse/nvim-window.git", lazy = false },
  { "nvim-lua/telescope.nvim", version = "0.1.5" },
  { "nvim-telescope/telescope-file-browser.nvim" },

  -- theme
  { "rebelot/kanagawa.nvim" },

  -- lsp
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'jay-babu/mason-null-ls.nvim' },

  -- syntax highlighting
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-context' },

  -- autocompletion
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },

  -- misc
  { "numToStr/Comment.nvim", lazy = false },
	-- TODO: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82
  { "JoosepAlviste/nvim-ts-context-commentstring" },
})

require("core.lsp").setup({
	language_servers = { "tsserver", },
	null_ls_sources = { "prettierd", },
	ts_languages = { "javascript", "typescript", "tsx", "json", "html", "css" }
})

-- setup plugins
require('Comment').setup { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() }

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

-- TODO: extract to core/mappings.lua
-- navigation mappings
vim.api.nvim_set_keymap("n", "<leader>w", ":lua require('nvim-window').pick()<CR>", { noremap = true })

-- telescope mappings
vim.api.nvim_set_keymap("n", "<leader><tab>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope grep_string<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true })

-- lsp mappings
vim.api.nvim_set_keymap("n", "<leader>gD", ":lua vim.lsp.buf.declaration()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>hv", ":lua vim.lsp.buf.hover()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dg", ":lua vim.diagnostic.setqflist()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rf", ":lua vim.lsp.buf.references()<CR>", { noremap = true })

-- format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
