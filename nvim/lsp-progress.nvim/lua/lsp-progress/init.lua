local M = {}

M.options = {
  messages = {
    commenced = "Loading workspace",
    completed = "Finish"
  }
}

function M.update_progress(self, client, trace_id, msg)
  local handlers = {
    ["begin"] = function()
      -- msg.title
      local record = vim.notify(msg.title or self.options.messages.commenced, vim.log.levels.INFO, {
        title = client.name,
        timeout = 1000,
        keep = function()
          return client.progresses[trace_id] ~= nil
        end
      })
      client.progresses[trace_id] = record and record.id
    end,
    ["report"] = function()
      local record = vim.notify(msg.message, vim.log.levels.INFO, {
        replace = client.progresses[trace_id]
      })
      client.progresses[trace_id] = record and record.id
    end,
    ["end"] = function()
      client.progresses[trace_id] = nil
    end
  }
  handlers[msg.kind]()
end

function M.get_client(self, client_id)
  local client_key = tostring(client_id)
  self.clients = self.clients or {}
  self.clients[client_key] = self.clients[client_key] or {
    progresses = {},
    name = vim.lsp.get_client_by_id(client_id).name
  }
  return self.clients[client_key]
end

function M.register_process(self)
  self.clients = {}

  local progress_callback = function(_, msg, info)
    local client_id = info.client_id
    local trace_id = msg.token
    local data = msg.value

    if not client_id or not data then
      return
    end

    local client = self:get_client(client_id);
    self:update_progress(client, trace_id, data)
  end

  vim.lsp.handlers["$/progress"] = function(err, msg, info, _)
    progress_callback(err, msg, info)
  end
end

function M.setup()
  M:register_process()
end

return M
