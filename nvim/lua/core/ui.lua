local feline = require("feline")
local bufferline = require("bufferline")

-- Set colorscheme (from core/colors.lua/colorscheme_name)
local colors = require("core/colors").monokai

local vi_mode_colors = {
  NORMAL = colors.cyan,
  INSERT = colors.green,
  VISUAL = colors.yellow,
  OP = colors.cyan,
  BLOCK = colors.cyan,
  REPLACE = colors.red,
  ["V-REPLACE"] = colors.red,
  ENTER = colors.orange,
  MORE = colors.orange,
  SELECT = colors.yellow,
  COMMAND = colors.pink,
  SHELL = colors.pink,
  TERM = colors.pink,
  NONE = colors.yellow,
}

-- Providers (LSP, vi_mode)
local vi_mode_utils = require("feline.providers.vi_mode")

-- My components
local comps = {
  -- vi_mode -> NORMAL, INSERT..
  vi_mode = {
    left = {
      provider = " ",
      hl = function()
        local set_color = {
          name = vi_mode_utils.get_mode_highlight_name(),
          fg = colors.bg,
          bg = vi_mode_utils.get_mode_color(),
          style = "bold",
        }
        return set_color
      end,
      left_sep = " ",
      right_sep = " ",
    },
  },
  -- Parse file information:
  file = {
    -- File name
    info = {
      provider = {
        name = "file_info",
        opts = {
          type = "relative",
          file_modified_icon = "",
        },
      },
      hl = { fg = colors.cyan },
      icon = "",
    },
    -- File type
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
          fg = colors.bg,
          bg = vi_mode_utils.get_mode_color(),
          style = "bold",
        }
        return set_color
      end
    },
    -- Line-column
    position = {
      provider = { name = "position" },
      hl = {
        fg = colors.fg,
        style = "bold",
      },
      left_sep = " ",
      right_sep = " ",
    },
  },
  -- LSP info
  diagnos = {
    err = {
      provider = "diagnostic_errors",
      icon = " ",
      hl = { fg = colors.red },
      left_sep = "  ",
    },
    warn = {
      provider = "diagnostic_warnings",
      icon = " ",
      hl = { fg = colors.yellow },
      left_sep = " ",
    },
    info = {
      provider = "diagnostic_info",
      icon = " ",
      hl = { fg = colors.green },
      left_sep = " ",
    },
    hint = {
      provider = "diagnostic_hints",
      icon = " ",
      hl = { fg = colors.cyan },
      left_sep = " ",
    },
  },
  lsp = {
    name = {
      provider = "lsp_client_names",
      icon = "  ",
      hl = { fg = colors.pink },
      left_sep = "  ",
      right_sep = " ",
    },
  },
  -- git info
  git = {
    branch = {
      provider = "git_branch",
      icon = " ",
      hl = { fg = colors.pink },
      left_sep = "  ",
    },
    add = {
      provider = "git_diff_added",
      icon = "  ",
      hl = { fg = colors.green },
      left_sep = " ",
    },
    change = {
      provider = "git_diff_changed",
      icon = "  ",
      hl = { fg = colors.orange },
      left_sep = " ",
    },
    remove = {
      provider = "git_diff_removed",
      icon = "  ",
      hl = { fg = colors.red },
      left_sep = " ",
    },
  },
}

-- Get active/inactive components
-- See: https://github.com/feline-nvim/feline.nvim/blob/master/USAGE.md#components
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
      comps.lsp.name,
      comps.file.type,
    }
  },
  inactive = {
    {
      comps.vi_mode.left,
    }
  },
}

-- Call feline
feline.setup({
  theme = {
    bg = colors.bg,
    fg = colors.fg,
  },
  components = components,
  --vi_mode_colors = vi_mode_colors,
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
})

bufferline.setup({})
