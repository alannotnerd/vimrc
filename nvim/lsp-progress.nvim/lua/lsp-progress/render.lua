local api = vim.api

local custom_render = function(bufnr, notif, highlights)
  local namespace = api.nvim_create_namespace("nvim-notify")
  api.nvim_buf_set_lines(bufnr, 0, -1, false, notif.message)

  api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    hl_group = highlights.icon,
    end_line = #notif.message - 1,
    end_col = #notif.message[#notif.message],
    priority = 50,
  })
end

return {
  custom_render = custom_render
}
