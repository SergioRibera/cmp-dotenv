local cmp = require('cmp')
local dotenv = require('cmp-dotenv.dotenv')

local source = {}

local defaults = {
  path = '.',
  load_shell = true,
  item_kind = cmp.lsp.CompletionItemKind.Variable,
  eval_on_confirm = false,
  show_documentation = true,
  documentation_kind = 'markdown',
  dotenv_environment = '.*', -- local,example or .* for any
  file_priority = function(a, b)
    return a:upper() < b:upper()
  end,
}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_keyword_pattern = function()
  return [[\k\+]]
end

source._validate_option = function(_, params)
  local opt = vim.tbl_deep_extend('keep', params.option, defaults)
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

source.complete = function(_, params, callback)
  local opt = vim.tbl_deep_extend('keep', params.option, defaults)
  dotenv.load(opt)
  callback(dotenv.as_completion(opt))
end

return source
