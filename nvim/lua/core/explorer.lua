local M = {}
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	Log:error("Nvim tree loaded failed")
end

function M.setup()
	local setup_config = require("core.config").nvim_tree
	nvim_tree.setup(setup_config)
end

return M
