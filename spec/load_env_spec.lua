local load_text = require('cmp-dotenv.load').load_data_from_text

describe('Load Env', function()
  it('Load env text', function()
    local env = 'VARIABLE=Hola Mundo'
    assert.are.same(load_text(env), { VARIABLE = { value = 'Hola Mundo', docs = nil } })
  end)

  it('Load env vars from text', function()
    local env = 'VARIABLE=Hola Mundo\nOTHER=Blah Blah Blah'
    assert.are.same(load_text(env), {
      VARIABLE = { value = 'Hola Mundo', docs = nil },
      OTHER = { value = 'Blah Blah Blah', docs = nil },
    })
  end)

  it('Load docs text', function()
    local env = '# Documentacion de prueba\nVARIABLE=Hola Mundo\n# Testeando ando\nOTRA_VARIABLE=Hello World'
    assert.are.same(load_text(env), {
      VARIABLE = { value = 'Hola Mundo', docs = 'Documentacion de prueba' },
      OTRA_VARIABLE = { value = 'Hello World', docs = 'Testeando ando' },
    })
  end)

  it('Load long docs text', function()
    local env =
      '# Documentacion de prueba\n# Documentacion de prueba\n# Documentacion de prueba\nVARIABLE=Hola Mundo\n# Testeando ando\nOTRA_VARIABLE=Hello World'
    assert.are.same(load_text(env), {
      VARIABLE = {
        value = 'Hola Mundo',
        docs = 'Documentacion de prueba\nDocumentacion de prueba\nDocumentacion de prueba',
      },
      OTRA_VARIABLE = { value = 'Hello World', docs = 'Testeando ando' },
    })
  end)
end)
