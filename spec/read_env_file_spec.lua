local load_text = require('cmp-dotenv.load').load_data

describe('Load dotenv', function()
  it('Load env file', function()
    assert.are.same(load_text('./spec/simple/.env', false), { VARIABLE = { value = 'Hola Mundo', docs = nil } })
  end)
  it('Load docs text', function()
    assert.are.same(load_text('./spec/simple/.env_docs', false), {
      VARIABLE = { value = 'Hola Mundo', docs = 'Documentacion de prueba' },
      OTRA_VARIABLE = { value = 'Hello World', docs = 'Testeando ando' },
    })
  end)
  it('Load long docs text', function()
    assert.are.same(load_text('./spec/simple/.env_long_docs', false), {
      VARIABLE = {
        value = 'Hola Mundo',
        docs = 'Documentacion de prueba\nDocumentacion de prueba\nDocumentacion de prueba',
      },
      OTRA_VARIABLE = { value = 'Hello World', docs = 'Testeando ando' },
    })
  end)
end)
