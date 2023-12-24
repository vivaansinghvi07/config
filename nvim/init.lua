require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
vim.wo.relativenumber = true

-- remember :lua require("base46").toggle_transparency()

require "plugins"

-- local Plug = vim.fn['plug#']
-- vim.cmd('call plug#begin()')
-- vim.cmd('Plug \'xiyaowong/transparent.nvim\'')
-- vim.cmd('call plug#end()')
