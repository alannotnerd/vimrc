local render = require("lsp-progress.render")

local M = {}

M.clients = {}

M.options = {
  messages = {
    commenced = "Loading workspace",
    completed = "Finish"
  }
}


function M.update_progress(self, client_id, trace_id, msg)
  local client = self:get_client(client_id)
  local handlers = {
    ["begin"] = function()
      local record = vim.notify(msg.message or self.options.messages.commenced, vim.log.levels.INFO, {
        title = msg.title,
        timeout = 1000,
        render = render.custom_render,
        keep = function()
          return client.progresses[trace_id] ~= nil
        end,
        replace = client.progresses[trace_id]
      })
      client.progresses[trace_id] = record.id
    end,
    ["report"] = function()
      local record = vim.notify(msg.message, vim.log.levels.INFO, {
        replace = client.progresses[trace_id]
      })
      client.progresses[trace_id] = record.id
    end,
    ["end"] = function()
      vim.defer_fn(function()
        client.progresses[trace_id] = nil
      end, 1000)
    end
  }
  handlers[msg.kind]()
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

    self:update_progress(client_id, trace_id, data)
  end

  vim.lsp.handlers["$/progress"] = function(err, msg, info, _)
    progress_callback(err, msg, info)
  end
end

function M.setup()
  M:register_process()
end

return M
