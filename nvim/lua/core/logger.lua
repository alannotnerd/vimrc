local Log = {}

Log.levels = {
  TRACE = 1,
  DEBUG = 2,
  INFO = 3,
  WARN = 4,
  ERROR = 5,
}
vim.tbl_add_reverse_lookup(Log.levels)

local notify_opts = {}

function Log:setup(config)
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return nil
  end
  self.config = config

  package.loaded["packer.log"] = nil
  require("packer.log").new { level = self.config.level }

  local log_level = Log.levels[(self.config.level):upper() or "WARN"]
  local log_conf = {
    [self.config.name] = {
      pipelines = {
        level = structlog.level.TRACE,
        processors = {
          structlog.processors.StackWriter({ "line", "file" }, { max_parents = 3, stack_level = 2 }),
          structlog.processors.Timestamper "%H:%M:%S",
        },
        formatter = structlog.formatters.Format(--
          "%s [%-5s] %s: %-30s",
          { "timestamp", "level", "logger_name", "msg" }
        ),
        sink = structlog.sinks.File(self:get_path()),
      }
    },
  }

  structlog.configure(log_conf)
  local logger = structlog.get_logger(self.config.name)
  self.__handle = logger
  
  local has_notify, notify = pcall(require, "notify")
  if not has_notify then
    return
  end

  vim.notify = notify.notify

  _G.Log = self
end

--- Adds a log entry using Plenary.log
---@param msg any
---@param level string [same as vim.log.log_levels]
function Log:add_entry(level, msg, event)
  local logger = self.__handle
  if not logger then
    return
  end
  logger:log(level, vim.inspect(msg), event)
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
  return string.format("%s/%s.log", vim.call('stdpath', 'cache'), self.config.name)
end

---Add a log entry at TRACE level
---@param msg any
---@param event any
function Log:trace(msg, event)
  self:add_entry(self.levels.TRACE, msg, event)
end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event)
  self:add_entry(self.levels.DEBUG, msg, event)
end

---Add a log entry at INFO level
---@param msg any
---@param event any
function Log:info(msg, event)
  self:add_entry(self.levels.INFO, msg, event)
end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event)
  self:add_entry(self.levels.WARN, msg, event)
end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event)
  self:add_entry(self.levels.ERROR, msg, event)
end

setmetatable({}, Log)

return Log
