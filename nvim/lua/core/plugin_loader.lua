local M = {}
local builtin_plugins = require("core.built_plugins")

function M.setup(plugins)
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  local first_install = false
  if fn.empty(fn.glob(install_path)) > 0 then
    first_install = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
  end

  local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    return
  end

  packer.startup({
    function(use)
      use("wbthomason/packer.nvim")
      use({
        "rcarriga/nvim-notify",
        requires = { "Tastyep/structlog.nvim" },
        config = function ()
          require("core.logger"):setup({ name = "aim", level = "DEBUG" })
        end
      })

      use({
        "feline-nvim/feline.nvim",
        requires = {
          "navarasu/onedark.nvim",
          "alannotnerd/monokai.nvim",
          "kyazdani42/nvim-web-devicons",
          { "akinsho/bufferline.nvim", tag = "v2.*" },
          "lukas-reineke/indent-blankline.nvim",
          { "rose-pine/neovim", as = "rose-pine" },
        },
        config = function ()
          require("core.ui").setup({
            colorscheme = "monokai"
          })
        end
      })

      use({
        "kyazdani42/nvim-tree.lua",
        config = function ()
          require("core.explorer").setup()
        end
      })

      use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
          require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function ()
          require("nvim-treesitter.configs").setup {
            ensure_installed = {
              'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua', 'python',
              'rust', 'typescript', 'vim', 'yaml',
            },
            sync_install = false,
            highlight = {
              enable = true,
            },
          }
        end
      })


      for _, builtin_plugin in pairs(builtin_plugins or {}) do
        use(builtin_plugin)
      end

      for _, plugin in pairs(plugins or {}) do
        use(plugin)
      end
    end,
    config = {
      non_interactive = true,
      autoremove = true
    }
})

  if first_install then
    require("packer").sync()
  end
end

return M
