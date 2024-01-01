local load = require('cmp-dotenv.load')
local option = require('cmp-dotenv.option')

local M = {}

M.files = {}
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

function M.set_env_variable(name, value, docs)
  vim.env[name] = value
  M.env_variables[name] = { value = value, docs = docs }
end

local function build_completions(opts)
  for key, v in pairs(M.env_variables) do
    local docs = ''
    if opts.show_content_on_docs then
      docs = 'Content: ' .. v.value
    end

    if v.docs ~= nil then
      docs = v.docs .. '\n\n' .. docs
    end

    table.insert(M.completion_items, {
      label = key,
      insertText = opts.eval_on_confirm and v.value or key,
      word = key,
      documentation = opts.show_documentation and {
        kind = opts.documentation_kind,
        value = docs,
      },
      kind = opts.item_kind,
    })
  end
end

function M.load(force, options)
  if vim.tbl_count(M.env_variables) > 0 or force then
    return
  end
  local opts = option.get(options)

  local raw_files = vim.fn.globpath(opts.path, '.env*', false, true)
  local files = vim.tbl_filter(function(v)
    return vim.regex('**/\\.env\\%(\\.' .. opts.dotenv_environment .. '\\)\\?$'):match_str(v) or false
  end, raw_files)

  table.sort(files, opts.file_priority)

  -- Get files not cached
  local diff_files = vim.tbl_filter(function(v)
    return not vim.tbl_get(M.files, v)
  end, files)

  -- If the new file list is same as cached
  -- return
  if vim.tbl_count(diff_files) == 0 and vim.tbl_count(M.env_variables) > 0 then
    return
  end

  M.files = files
  M.env_variables = {}
  M.completion_items = {}

  if opts.load_shell then
    local env_vars = vim.fn.environ()
    for key, value in pairs(env_vars) do
      M.env_variables[key] = { value = value, docs = '**From Shell**' }
    end
  end

  for i = 1, #M.files do
    local file = M.files[i]
    local data = load.load_data(file, false)
    for key, v in pairs(data) do
      M.set_env_variable(key, v.value, v.docs)
    end
  end

  build_completions(opts)
end

function M.as_completion()
  return M.completion_items
end

return M
