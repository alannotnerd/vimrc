local M = { "windwp/nvim-autopairs" }

function M.config()
  local Rule = require("nvim-autopairs.rule")
  local npairs = require("nvim-autopairs")

  npairs.setup({
    check_ts = true,
    map_cr = false,
    fast_wrap = {}
  })
end

return M
