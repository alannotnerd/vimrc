local M = {}

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
        "kyazdani42/nvim-tree.lua",
        requires = {
          "kyazdani42/nvim-web-devicons"
        }
      })
      use("lukas-reineke/indent-blankline.nvim")
      use("Tastyep/structlog.nvim")
      use("rcarriga/nvim-notify")
      use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
          require("nvim-treesitter.install").update({ with_sync = true })
        end,
      })
      use({ "feline-nvim/feline.nvim", branch = '0.5-compat', requires = { "kyazdani42/nvim-web-devicons" } })
      use({ "goolord/alpha-nvim", requires = { "kyazdani42/nvim-web-devicons" } })
      use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

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
