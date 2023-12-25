# Contributing guide

Contributions are more than welcome!

Please don't forget to add your changes to the "Unreleased" section of
[the changelog](./CHANGELOG.md) (if applicable).

## Commit messages

This project uses
[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

## Development

I use [`nix`](https://nixos.org/download.html#download-nix)
(with flakes enabled) for development and testing.

Formatting is done with [`stylua`](https://github.com/JohnnyMorganz/StyLua).

To enter a development shell:

```console
nix develop
```

To apply formatting, while in a devShell, run

```console
pre-commit run --all
```

If you use [`direnv`](https://direnv.net/),
just run `direnv allow` and you will be dropped in this devShell.

## Tests

### Running tests

I use [`busted`](https://lunarmodules.github.io/busted/) for testing,
but with Neovim as the Lua interpreter.

The easiest way to run tests is with Nix (see below).

If you do not use Nix, you can also run the test suite using `luarocks test`.
For more information on how to set up Neovim as a Lua interpreter, see

- The [neorocks tutorial](https://github.com/nvim-neorocks/neorocks#without-neolua).

Or

- [`nlua`](https://github.com/mfussenegger/nlua).

> [!NOTE]
>
> The Nix devShell sets up `luarocks test` to use Neovim as the interpreter.

### Running tests and checks with Nix

If you just want to run all checks that are available,
run:

```console
nix flake check --print-build-logs
```

To run tests locally

```console
nix build .#checks.<your-system>.ci --print-build-logs
```

For formatting:

```console
nix build .#checks.<your-system>.formatting --print-build-logs
```
