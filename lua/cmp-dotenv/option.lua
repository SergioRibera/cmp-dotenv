local cmp = require('cmp')
local config = require('cmp.config')

local option = {}

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

function option.get(options)
  local cmp_opt = {}
  if config and config.get_source_config('dotenv') then
    cmp_opt = config.get_source_config('dotenv').option
  end
  local opt = options or cmp_opt
  return vim.tbl_deep_extend('keep', opt, defaults)
end

return option
