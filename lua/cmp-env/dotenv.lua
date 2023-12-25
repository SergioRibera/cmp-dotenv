local load = require('cmp-env.load')
local M = {}

M.completion_items = {}
M.env_variables = {}

function M.get_env_variable(name, default)
  if M.env_variables[name] then
    return M.env_variables[name]
  else
    return default
  end
end

M.get_all_env = function()
  return M.env_variables
end

function M.set_env_variable(name, value, doc)
  local docs = '> From lua invocation\n' .. doc
  vim.env[name] = value
  M.env_variables[name] = { value = value, docs = docs }
end

-- TODO: support markdown docs as commentary up to value definition
function M.load()
  if #M.env_variables > 0 then
    return
  end

  local files = vim.fs.find('.env', { upward = true, type = 'file' })

  for i = 1, #files do
    local file = files[i]
    local data = load.load_data(file, false)
    for key, value in pairs(data) do
      M.set_env_variable(key, value)
    end
  end

  local env_vars = vim.fn.environ()
  for key, value in pairs(env_vars) do
    M.set_env_variable(key, value)
  end
end

function M.as_completion(opts)
  if #M.completion_items > 0 then
    return M.completion_items
  end

  for key, value in pairs(M.env_variables) do
    table.insert(M.completion_items, {
      label = key,
      -- Evaluate the environment variable if `eval_on_confirm` is true
      insertText = opts.eval_on_confirm and value or key,
      word = key,
      -- Show documentation if `show_documentation_window` is true
      documentation = opts.show_documentation_window and {
        kind = 'markdown',
        value = value.docs,
      },
      kind = opts.item_kind,
    })
  end
end

return M
