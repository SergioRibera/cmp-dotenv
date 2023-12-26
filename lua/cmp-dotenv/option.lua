local cmp = require('cmp')
local config = require('cmp.config')

local option = {}
option.opts = nil

local defaults = {
  path = '.',
  load_shell = true,
  item_kind = cmp.lsp.CompletionItemKind.Variable,
  eval_on_confirm = false,
  show_documentation = true,
  show_content_on_docs = true,
  documentation_kind = 'markdown',
  dotenv_environment = '.*', -- local,example or .* for any
  file_priority = function(a, b)
    return a:upper() < b:upper()
  end,
}

function option.set(options)
  option.opts = options
end

function option.get(options)
  local opt = options or option.opts or config.get_source_config('dotenv').option
  return vim.tbl_deep_extend('keep', opt or {}, defaults)
end

return option
