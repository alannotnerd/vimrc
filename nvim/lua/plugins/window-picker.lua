return {
  "s1n7ax/nvim-window-picker",
  version = "2.*",
  opts = {
    -- hint = "floating-big-letter",
    show_prompt = false,
    picker_config = {
      statusline_winbar_picker = {
        use_winbar = "always",
      },
    },

    filter_rules = {
      include_current_win = false,
      autoselect_one = true,
      -- filter using buffer options
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = { "neo-tree", "neo-tree-popup", "notify" },
        -- if the buffer type is one of following, the window will be ignored
        buftype = { "terminal", "quickfix" },
      },
    },
  },
}
