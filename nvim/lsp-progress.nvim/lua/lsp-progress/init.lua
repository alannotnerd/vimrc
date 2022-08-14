local M = {}

M.options = {
  messages = {
    commenced = "Loading workspace",
    completed = "Finish"

  }
}

function M.register_process(self)
  self.clients = {}

  self.progress_callback = function(_, msg, info)
    local client_key = tostring(info.client_id)
    local key = msg.token
    local val = msg.value

    if not client_key then
      return
    end

    if self.clients[client_key] == nil then
      self.clients[client_key] = {
        progresses = {},
        name = { name = vim.lsp.get_client_by_id(info.client_id).name }
      }
    end

    local progresses = self.clients[client_key].progresses

    if val then
      if val.kind == 'begin' then
        local record = vim.notify(key .. ":" .. self.options.messages.commenced, vim.log.levels.INFO, {
          title = val.title,
          timeout = false,
        })
        progresses[key] = record and record.id
      end

      if val.kind == 'report' then
        local record = vim.notify(key .. ":" .. val.message, vim.log.levels.INFO, {
          replace = progresses[key]
        })
        progresses[key] = record and record.id
      end

      if val.kind == 'end' then
        vim.notify(self.options.messages.completed, vim.log.levels.INFO, {
          timeout = 1000,
          replace = progresses[key],
          on_close = function()
            progresses[key] = nil
          end
        })
      end
    end
  end

  vim.lsp.handlers["$/progress"] = function(err, msg, info, _)
    self.progress_callback(err, msg, info)
  end
end

function M.setup()
  M:register_process()
end

return M
