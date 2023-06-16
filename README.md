# tmillr's Neovim configuration and plugins using nix

## Discussion

> **Note** drv means derivation, deps means dependencies

Nix ships wrapper utilities and wrapper derivations for the neovim package/drv. The wrappers are used to:

- Optionally bundle config (plugin config, vimrc, etc.) so that the package/drv build is more "static" and doesn't depend on anything (e.g. mutable files) outside of the nix store

- Bundle plugins (i.e. copy/symlink plugins into the store and into the built neovim pkg, ensure the neovim build depends on its plugins from nix's POV so that the plugins aren't garbage-collected (and so that they will appear as dependencies of the neovim build when doing commands like `nix-store -q --references`), automatically setup vim's `packdir` and/or `rtp` according to which plugins have been bundled, and optionally bundle the user's own plugin-config files for each plugin for similar reasons/benefits)

- Detect and bundle dependencies of plugins (although this might not work out-of-the-box with custom pkgs/plugins that don't ship with nix by default). Outside of nix, Neovim plugins have different ways of handling their dependencies; usually they either include them directly via git submodules or instruct the user to download and install them manually (although the user might use a pkg manager such as packer or luarocks to make this process easier/more automatic).

- Bundle and setup "remote" plugin hosts (e.g. Python interpreter and environment). This is for certain types of plugins that run in an external process and communicate with Neovim over IPC. Most nvim plugins are written in Lua however and run in-process.

> **Note** By _bundling_ I mean that, at build time, such files/dirs have been copied into the immutable nix store and then (from there) copied or symlinked into the build itself. This ensures that such files are hashed and recorded/noted/identified as runtime dependencies of the build by nix, as well as always available and static/immutable. Copying to the store and bundling such files that neovim uses at runtime has the benefit of ensuring that the build is reproducible and that Neovim's runtime files/plugins/config/etc. (aka its runtime dependencies) are always available and don't change over time (as the store is immutable, and as, in nix, a build's recorded dependencies cannot be easily/normally deleted from the store unless the entire build/dependent is removed too). This has the added benefit that the deps of the neovim build or drv can be viewed/queried with certain nix commands such as `nix-store -q --references`.

There are two neovim wrappers currently shipped by nix: `nixpkgs.wrapNeovim` and `nixpkgs.wrapNeovimUnstable`.

```nix
  wrapNeovimUnstable = callPackage ../applications/editors/neovim/wrapper.nix { };

  wrapNeovim = neovim-unwrapped: lib.makeOverridable (neovimUtils.legacyWrapper neovim-unwrapped);
```

`neovimUtils.legacyWrapper` is defined in `../applications/editors/neovim/utils.nix`. In that file, there is also the function `makeNeovimConfig`. `legacyWrapper` takes a `neovim` drv as parameter and calls `makeNeovimConfig` (the result of which is then passed (along with `neovim`) to `wrapNeovimUnstable`—the return value of this call to `wrapNeovimUnstable` becomes the return value of `legacyWrapper`).

`wrapper.nix` is defined similarly to how most other packages/derivations in nixpkgs are defined and it exposes/returns a `symlinkJoin` derivation. It defines a top-level function which accepts an attribute set of several top-level nixpkgs attributes (its dependencies essentially) and returns another function which takes a `neovim` parameter (i.e. the neovim drv to wrap) (also a dependency). It ultimately returns a `symlinkJoin` drv.

Neovim's wrapper's and utils also depend on vimUtils to an extent.

TODO: describe `buildVimPlugin` or `buildNeovimPlugin` etc., and how the legacy wrapper differs from the unstable one?

The [current documentation][nix-docs-vim] has not been updated yet to cover the new/unstable wrapper and still instructs one to use the legacy wrapper.

[nix-docs-vim]: https://github.com/NixOS/nixpkgs/blob/7c67f006ea0e7d0265f16d7df07cc076fdffd91f/doc/languages-frameworks/vim.section.md
[nix-docs-vim-current]: https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md
