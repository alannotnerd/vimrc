local M = {}

M.clients = {}

M.options = {
  messages = {
    commenced = "Loading workspace",
    completed = "Finish"
  }
}

function M.update_progress(self, client, trace_id, msg)
  local handlers = {
    ["begin"] = function()
      local record = vim.notify(msg.message or self.options.messages.commenced, vim.log.levels.INFO, {
        title = msg.title,
        timeout = 0,
        keep = function()
          return self:get_progress_record_id(client, trace_id) ~= nil
        end,
        replace = self:get_progress_record_id(client, trace_id)
      })
      self:set_progress_record_id(client, trace_id, record.id)
    end,
    ["report"] = function()
      local record = vim.notify(msg.message, vim.log.levels.INFO, {
        replace = self:get_progress_record_id(client, trace_id)
      })
      self:set_progress_record_id(client, trace_id, record.id)
    end,
    ["end"] = function()
      self:clear_progress_record_id(client, trace_id)
    end
  }
  handlers[msg.kind]()
end

function M.set_progress_record_id(self, client, trace_id, record_id)
  local progresses_info = client.progresses[trace_id]
  if progresses_info and progresses_info.timer then
    progresses_info.timer:stop()
  end

  client.progresses[trace_id] = {
    timer = nil,
    value = record_id,
  }
end

function M.clear_progress_record_id(self, client, trace_id)
  local progresses_info = client.progresses[trace_id]
  if progresses_info == nil or progresses_info.timer ~= nil then
    return
  end

  local timer = vim.defer_fn(function()
    client.progresses[trace_id] = nil
  end, 1000)
  client.progresses[trace_id].timer = timer
end

function M.get_progress_record_id(self, client, trace_id)
  local progresses_info = client.progresses[trace_id]
  if not progresses_info then
    return nil
  end

  return progresses_info.value
end

function M.get_client(self, client_id)
  self.clients[client_id] = self.clients[client_id] or {
    progresses = {},
    name = vim.lsp.get_client_by_id(client_id).name
  }
  return self.clients[client_id]
end

function M.register_process(self)
  local progress_callback = function(_, msg, info)
    local client_id = info.client_id
    local trace_id = tostring(msg.token)
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
