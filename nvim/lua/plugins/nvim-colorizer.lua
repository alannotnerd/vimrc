local M = {
  "norcalli/nvim-colorizer.lua",
  config = function()
    local status_ok, mod = pcall(require, 'colorizer')
    if status_ok then
      mod.setup()
    end
  end
}

return M
