<!-- markdownlint-disable -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.1.0] - 2023-09-05

### Added

- Use `neorocksTest`.

### Changed

- Bump `luarocks-tag-release` version.

### Fixed

- Fail release if changelog entry doesn't exist.

## [3.0.0] - 2023-08-16

### Fixed

- Luarocks Upload workflow.

### Changed

- Loosen license restrictions to allow any OSI approved open source derivations.
- Switch from `flake-utils` to `flake-parts`.

### Added

- More pre-commit-hooks and linters.
- `luarocks-tag-release` workflow.
- Add lua-ls pre-commit checks.

### Changed

- Remove `cachix-action` from workflow.

## [2.0.0] - 2023-01-02

### Changed

- Replace `nixpkgs-fmt` with `alejandra`.

## [1.0.0] - 2022-10-20

### Added

- Initial release
