local M = {}

local feline = require("feline")
local bufferline = require("bufferline")

function M.setup(config)
  local vi_mode_utils = require("feline.providers.vi_mode")
  local comps = {
    vi_mode = {
      left = {
        provider = " ",
        hl = function()
          local set_color = {
            name = vi_mode_utils.get_mode_highlight_name(),
            bg = vi_mode_utils.get_mode_color(),
            style = "bold",
          }
          return set_color
        end,
        left_sep = " ",
        right_sep = " ",
      },
    },
    file = {
      info = {
        provider = {
          name = "file_info",
          opts = {
            type = "relative",
            file_modified_icon = "",
          },
        },
        icon = "",
      },
      type = {
        provider = function()
          local type = vim.bo.filetype:lower()
          local extension = vim.fn.expand("%:e") ---@diagnostic disable-line
          local icon = require("nvim-web-devicons").get_icon(extension)
          if icon == nil then
            icon = " "
          end
          return " " .. icon .. " " .. type .. " "
        end,
        hl = function()
          local set_color = {
            name = vi_mode_utils.get_mode_highlight_name(),
            bg = vi_mode_utils.get_mode_color(),
            style = "bold", }
          return set_color
        end
      },
      -- Line-column
      position = {
        provider = { name = "position" },
        hl = {
          style = "bold",
        },
        left_sep = " ",
        right_sep = " ",
      },
    },
    -- LSP info
    diagnos = {
      err = {
        provider = {
          name = "coc_diagnostic_info",
          opts = "error"
        },
        icon = " ",
        hl = "DiagnosticSignError",
        left_sep = "  ",
      },
      warn = {
        provider = {
          name = "coc_diagnostic_info",
          opts = "warning"
        },
        icon = " ",
        hl = "DiagnosticSignWarn",
        left_sep = " ",
      },
      info = {
        provider = {
          name = "coc_diagnostic_info",
          opts = "information"
        },
        icon = " ",
        hl = "DiagnosticSignInfo",
        left_sep = " ",
      },
      hint = {
        provider = {
          name = "coc_diagnostic_info",
          opts = "hint"
        },
        icon = " ",
        hl = "DiagnosticSignHint",
        left_sep = " ",
      },
    },
    -- git info
    git = {
      branch = {
        provider = "git_branch",
        icon = " ",
        hl = "GitSignsAdd",
        left_sep = "  ",
      },
      add = {
        provider = "git_diff_added",
        icon = " ",
        hl = "GitSignsAdd",
        left_sep = " ",
      },
      change = {
        provider = "git_diff_changed",
        icon = " ",
        hl = "GitSignsChange",
        left_sep = " ",
      },
      remove = {
        provider = "git_diff_removed",
        icon = " ",
        hl = "GitSignsDelete",
        left_sep = " ",
      },
    },
  }

  local components = {
    active = {
      -- Lefy section
      {
        comps.vi_mode.left,
        comps.file.info,
        comps.git.branch,
        comps.git.add,
        comps.git.change,
        comps.git.remove,
      },
      -- Right section
      {
        comps.diagnos.err,
        comps.diagnos.warn,
        comps.diagnos.hint,
        comps.diagnos.info,
        comps.file.type,
      }
    },
    inactive = {
      {
        comps.vi_mode.left,
      }
    },
  }

  feline.setup({
    components = components,
    custom_providers = {
      coc_diagnostic_info = function (_, security)
        local info = vim.b.coc_diagnostic_info or {
          warning = 0,
          information = 0,
          error = 0,
          hint = 0,
        }
        return tostring(info[security])
      end
    },
    force_inactive = {
      filetypes = {
        "^NvimTree$",
        "^packer$",
        "^vista$",
        "^help$",
      },
      buftypes = {
        "^terminal$",
      },
      bufnames = {},
    },
    vi_mode_colors = {
      NORMAL = 'skyblue',
      INSERT = "green",
      VISUAL = "yellow",
      OP = "cyan",
      BLOCK = "cyan",
      REPLACE = "red",
      ["V-REPLACE"] = "red",
      ENTER = "orange",
      MORE = "orange",
      SELECT = "yellow",
      COMMAND = "pink",
      SHELL = "pink",
      TERM = "pink",
      NONE = "yellow",
    },
    theme = {
      bg = 'bg'
    }
  })
  bufferline.setup({})
end

return M
