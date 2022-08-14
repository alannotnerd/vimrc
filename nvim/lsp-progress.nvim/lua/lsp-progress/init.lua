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
    local key = msg.token
    local val = msg.value
    local client_key = tostring(info.client_id)

    if not client_key then
      return
    end

    if self.clients[client_key] == nil then
      self.clients[client_key] = {
        progress = {},
        name = { name = vim.lsp.get_client_by_id(info.client_id).name }
      }
    end

    local progress_collection = self.clients[client_key].progress
    if progress_collection[key] == nil then
      progress_collection[key] = { title = nil, message = nil, percentage = nil }
    end

    local progress = progress_collection[key]
    if val then
      if val.kind == 'begin' then
        progress.title = val.title
        progress.message = self.options.messages.commenced
      end

      if val.kind == 'report' then
        if val.percentage then
          progress.percentage = val.percentage
        end

        if val.message then
          progress.message = val.message
        end
      end

      if val.kind == 'end' then
        if progress.percentage then
          progress.percentage = '100'
        end
        progress.message = self.options.messages.completed
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
