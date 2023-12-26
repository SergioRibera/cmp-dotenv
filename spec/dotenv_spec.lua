local dotenv = require('cmp-dotenv.dotenv')

local default_opts = {
  path = './spec/dotenv',
  load_shell = false,
  dotenv_environment = '.*', -- load all .env files
  file_priority = function(a, b)
    -- Prioritizing local files
    return a:upper() < b:upper()
  end,
}

describe('Load dotenv workspace', function()
  it('Load env text', function()
    dotenv.env_variables = {}
    dotenv.load(default_opts)
    local all_env = dotenv.get_all_env()
    assert.are.same(3, vim.tbl_count(all_env))
    assert.are.same({ value = 'Hello From Local', docs = 'Local Documentation' }, all_env.VARIABLE)
    assert.are.same({ value = 'Local Data', docs = nil }, all_env.LOCAL_VAR)
    assert.are.same({ value = 'Other Local Value', docs = 'Local Test' }, all_env.OTHER_VARIABLE)
  end)

  it('Load local env variables', function()
    dotenv.env_variables = {}
    local opt = vim.tbl_deep_extend('keep', { dotenv_environment = 'local' }, default_opts)
    dotenv.load(opt)
    local all_env = dotenv.get_all_env()
    assert.are.same(3, vim.tbl_count(all_env))
    assert.are.same({ value = 'Hello From Local', docs = 'Local Documentation' }, all_env.VARIABLE)
    assert.are.same({ value = 'Local Data', docs = nil }, all_env.LOCAL_VAR)
  end)

  it('Load example env variables', function()
    dotenv.env_variables = {}
    local opt = vim.tbl_deep_extend('keep', { dotenv_environment = 'example' }, default_opts)
    dotenv.load(opt)
    local all_env = dotenv.get_all_env()
    assert.are.same(2, vim.tbl_count(all_env))
  end)
end)
