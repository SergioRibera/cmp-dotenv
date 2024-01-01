local dotenv = require('cmp-dotenv.dotenv')

local default_opts = {
  path = './spec/dotenv',
  load_shell = false,
  eval_on_confirm = false,
  dotenv_environment = '.*', -- load all .env files
  file_priority = function(a, b)
    -- Prioritizing local files
    return a:upper() < b:upper()
  end,
}

local function tbl_find(t, n)
  for _, value in ipairs(t) do
    if value.word == n then
      return value
    end
  end
end

describe('Load dotenv workspace', function()
  it('Load env text', function()
    dotenv.load(true, default_opts)
    local all_env = dotenv.get_all_env()
    assert.are.same(3, vim.tbl_count(all_env))
    assert.are.same(
      { value = 'Hello From Local', docs = 'Local Documentation\n\nLocal Documentation Next Line' },
      all_env.VARIABLE
    )
    assert.are.same({ value = 'Local Data', docs = nil }, all_env.LOCAL_VAR)
    assert.are.same({ value = 'Other Local Value', docs = 'Local Test' }, all_env.OTHER_VARIABLE)
  end)

  it('Load local env variables', function()
    local opt = vim.tbl_deep_extend('keep', { dotenv_environment = 'local' }, default_opts)
    dotenv.load(true, opt)
    local all_env = dotenv.get_all_env()
    assert.are.same(3, vim.tbl_count(all_env))
    assert.are.same(
      { value = 'Hello From Local', docs = 'Local Documentation\n\nLocal Documentation Next Line' },
      all_env.VARIABLE
    )
    assert.are.same({ value = 'Local Data', docs = nil }, all_env.LOCAL_VAR)
  end)

  it('Load example env variables', function()
    local opt = vim.tbl_deep_extend('keep', { dotenv_environment = 'example' }, default_opts)
    dotenv.load(true, opt)
    local all_env = dotenv.get_all_env()
    assert.are.same(2, vim.tbl_count(all_env))
  end)
end)

describe('Completion dotenv workspace', function()
  it('Load completion table', function()
    dotenv.load(true, default_opts)
    local all = dotenv.as_completion()

    assert.are.same(3, vim.tbl_count(all))

    local variable = tbl_find(all, 'VARIABLE')
    assert.are.same('VARIABLE', variable.label)
    assert.are.same('VARIABLE', variable.insertText)
    assert.are.same(
      'Local Documentation\n\nLocal Documentation Next Line\n\nContent: Hello From Local',
      variable.documentation.value
    )
  end)
end)
