local M = {}

local function get_lines(str)
  local t = {}
  local function helper(line)
    table.insert(t, line)
    return ''
  end
  helper((str:gsub('(.-)\r?\n', helper)))
  return t
end
local function split_str(str, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for s in string.gmatch(str, '([^' .. sep .. ']+)') do
    table.insert(t, s)
  end
  return t
end

function M.load_data(file_path, create_if_not_exists)
  local file, _ = io.open(file_path, 'r')
  local data_loaded = {}
  if file == nil and create_if_not_exists == true then
    local f = io.open(file_path, 'w')
    if f ~= nil then
      f:write('')
    end
  else
    if file ~= nil then
      local content = file:read('*a')
      if file ~= nil then
        data_loaded = M.load_data_from_text(content)
        file:close()
      end
    end
  end
  return data_loaded
end

function M.load_data_from_text(content)
  local data_loaded = {}
  local lines_arr = get_lines(content)
  if next(lines_arr) ~= nil then
    local docs = nil
    for v in pairs(lines_arr) do
      local line = lines_arr[v]
      if not (line == nil or line == '') and string.sub(line, 1, 1) ~= '#' then
        local raw_values = split_str(line, '=')
        local value = raw_values[2] and vim.trim(raw_values[2]) or ''
        data_loaded[raw_values[1]] = { value = value, docs = docs and vim.trim(docs) or nil }
        docs = nil
      else
        docs = (docs or '') .. vim.trim(string.sub(line, 2)) .. '\n'
      end
    end
  end
  return data_loaded
end

return M
