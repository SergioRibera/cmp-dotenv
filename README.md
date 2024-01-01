# cmp-dotenv
https://github.com/SergioRibera/cmp-dotenv/assets/56278796/8a23c17a-6f08-45db-b567-de47cd9a8a81

|  Wihtout cmp-dotenv  | With cmp-dotenv |
|----------------------|-----------------|
| ![image](https://github.com/SergioRibera/cmp-dotenv/assets/56278796/28c1123a-62b5-414d-8b54-4705dffbe966) | ![image](https://github.com/SergioRibera/cmp-dotenv/assets/56278796/30aa4131-28f7-4295-82aa-9cf7df279647) |


The plugin you need to have an autocomplete of the environment variables of your system
and those of your `.env*` files

## Setup

```lua
require("cmp").setup {
    sources = {
        { name = "dotenv" }
    }
}
```

Or with configuration

```lua
local cmp = require("cmp")

cmp.setup {
    sources = {
        {
          name = "env",
          -- Defaults
          option = {
            path = '.',
            load_shell = true,
            item_kind = cmp.lsp.CompletionItemKind.Variable,
            eval_on_confirm = false,
            show_documentation = true,
            show_content_on_docs = true,
            documentation_kind = 'markdown',
            dotenv_environment = '.*',
            file_priority = function(a, b)
              -- Prioritizing local files
              return a:upper() < b:upper()
            end,
          }
        }
    }
}
```

## Options

| name                 | default                                                                              | description                                                                                                                                                                              |
|----------------------|--------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| path                 | '.'                                                                                  | The path where to look for the files                                                                                                                                                     |
| load_shell           | true                                                                                 | Do you want to load shell variables?                                                                                                                                                     |
| item_kind            | [Variable](https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/types/lsp.lua#L178) | What kind of suggestion will cmp make?                                                                                                                                                   |
| eval_on_confirm      | false                                                                                | When you confirm the completion, do you want the variable or the value?                                                                                                                  |
| show_documentation   | true                                                                                 | Do you want to see the documentation that has the variable?                                                                                                                              |
| show_content_on_docs | true                                                                                 | Allows to preview the content in the documentation popup with the prefix of `Content: `.                                                                                                 |
| documentation_kind   | 'markdown'                                                                           | What did you write the variable documentation on?                                                                                                                                        |
| dotenv_environment   | '.*'                                                                                 | Which variable environment do you want to load? `.*` by default loads all of them, this variable accepts regex, some suggestions I can give you are `example`, `local` or `development`. |
| file_priority        | function                                                                             | With this function you define the upload priority, by default it prioritizes the local variables, this responds to the callback of a computer for the found files.                       |

## Advanced Usage

If you are a developer or just want to do more things in your lua configuration,
you can use the api provided here and the (recommended) functions available, are these

```lua
local dotenv = require('cmp-dotenv.dotenv')

-- Get the variable you want by name or
-- get the default value in case it does not exist.
dotenv.get_env_variable(name, default)

-- Get all variables that have been loaded
dotenv.get_all_env()

-- You can set a variable to the auto-completion system and
-- find it available throughout the Neovim environment.
-- You can pass it a documentation in the format
-- you have configured or not pass it at all.
dotenv.set_env_variable(name, value, docs or nil)

-- This loads all the environment variables according to the
-- configuration you have from the files or the shell,
-- I do not recommend calling this function as it is
-- usually called by default by cmp.
dotenv.load(force, options)
```

## Contributing

All contributions are welcome!
See [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

This template is [licensed according to GPL version 2](./LICENSE),
with the following exception:

The license applies only to the Nix CI infrastructure provided by this template
repository, including any modifications made to the infrastructure.
Any software that uses or is derived from this template may be licensed under any
[OSI approved open source license](https://opensource.org/licenses/),
without being subject to the GPL version 2 license of this template.
