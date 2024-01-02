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
  { "https://gitlab.com/yorickpeterse/nvim-window.git", lazy = false },
  { "numToStr/Comment.nvim", lazy = false }
})
