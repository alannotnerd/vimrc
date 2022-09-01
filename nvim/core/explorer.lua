local M = {}

function M.setup()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")
  if not status_ok then
    Log:error("Nvim tree loaded failed")
    return
  end

	nvim_tree.setup({
    view = {
      hide_root_folder = true,
      mappings = {
        custom_only = true,
        list = {
          { key = { "o", "e" }, action = "edit" },
          { key =  "<CR>" , action = "cd" },
          { key = "E", action = "vsplit" },
          { key = "s", action = "split" },
          { key = "<BS>", action = "dir_up" },
          { key = "yy", action = "copy" },
          { key = "r", action = "rename" },
          { key = "df", action = "cut" },
          { key = "a", action = "create" },
          { key = "dd", action = "remove" },
          { key = "gg", action = "toggle_git_ignored" },
          { key = "g.", action = "toggle_dotfiles" },
          { key = "q", action = "close" },
          { key = "p", action = "paste" },
        },
      },
    },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "",
            untracked = "",
            deleted = "",
            ignored = "",
          },
          -- git = {
          -- 	unstaged = "✗",
          -- 	staged = "✓",
          -- 	unmerged = "",
          -- 	renamed = "➜",
          -- 	untracked = "★",
          -- 	deleted = "",
          -- 	ignored = "◌",
          -- },
        },
      }
    }

  })
end

return M
