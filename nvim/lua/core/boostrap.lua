_G.root_dir = function()
  return vim.fn.getcwd()
end

_G.cache_dir = function()
  return vim.call('stdpath', 'cache')
end

_G.config_dir = function(path)
  return vim.call('stdpath', 'config') .. path
end

require('packer_init')

local Log = require('core.log')
local notify = require('notify')
vim.notify = notify.notify

Log:configure_notifications(notify.notify)
_G.Log = Log
