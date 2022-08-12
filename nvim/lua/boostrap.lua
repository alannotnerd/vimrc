require('packer_init')

local Log = require('core.log')
local notify = require('notify')

Log:configure_notifications(notify)
Log:info("Logger initialized")

_G.Log = Log
_G.root_dir = function ()
  return vim.fn.getcwd()
end
_G.cache_dir = function ()
  return vim.call('stdpath', 'cache')
end



