require("core.bootstrap")

require("core.options").setup()
require("core.keymaps").setup()
require("core.plugin_loader").setup()
require("core.logger"):setup({ name = "aim", level = "DEBUG" })

require("core.explorer").setup()

