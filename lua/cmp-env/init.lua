local dotenv = require('cmp-env.dotenv')

local source = {}

local defaults = {}

source.new = function()
  dotenv.load()
  return setmetatable({}, { __index = source })
end

source.get_keyword_pattern = function()
  return '\\$[^[:blank:]]*'
end

source._validate_option = function(_, params)
  local opt = vim.tbl_deep_extend('keep', params.option, defaults)
  vim.validate {}
  return opt
end

source.complete = function(_, params, callback)
  local opt = vim.tbl_deep_extend('keep', params.option, defaults)
  callback(dotenv.as_completion(opt))
end

return source
