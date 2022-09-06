local M ={
  "akinsho/toggleterm.nvim",
  config = function ()
    local ok, term = pcall(require, "toggleterm") 
    if not ok then
      Log:error("mode [toggleterm] is not installed")
      return
    end
    term.setup({
      autochdir = true,
      open_mapping = [[<C-t>]],
      direction = "float",
      float_opts = {
        border = 'curved'
      }
    })
  end
}

return M
