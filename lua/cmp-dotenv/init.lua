local dotenv = require('cmp-dotenv.dotenv')
local option = require('cmp-dotenv.option')

local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_keyword_pattern = function()
  return [[\k\+]]
end

source._validate_option = function(_, _)
  local opt = option.get()
  vim.validate {
    path = { opt.path, 'string' },
    load_shell = { opt.load_shell, 'boolean' },
    item_kind = { opt.item_kind, 'number' },
    eval_on_confirm = { opt.eval_on_confirm, 'boolean' },
    show_documentation = { opt.show_documentation, 'boolean' },
    documentation_kind = { opt.documentation_kind, 'string' },
    file_filter = { opt.file_filter, 'string' },
    file_priority = { opt.file_priority, 'function' },
  }
  return opt
end

source.complete = function(_, _, callback)
  callback(dotenv.as_completion())
end

return source
