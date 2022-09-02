local M = {}

function M.setup()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")
  if not status_ok then
    Log:error("Nvim tree loaded failed")
    return
  end

	nvim_tree.setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    reload_on_bufenter = true,
    actions = {
      change_dir = {
        global = true
      }
    },
    view = {
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
      highlight_git = true,
      icons = {
        show = {
          git = false
        },
      }
    }

  })
end

return M
