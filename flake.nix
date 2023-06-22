# TODO: nvim config, bundle nvim?, rc script to set rtp etc. and/or load
# plugins, plugin black/white list or override mechanism, nvim HEAD install,
# ts parser path, docs outputs, check references, system setting
{
  description = "@tmillr's Neovim plugins";

  inputs = {
    # TODO:
    # Colorschemes
    # (Plugin {
    #   owner = "sainnhe";
    #   repo = "edge";
    # })

    # (Plugin {
    #   owner = "gerardbm";
    #   repo = "vim-atomic";
    # })

    # Color scheme used in the GIFs!

    # Plug stdpath('data') . '/plugged' . '/diffchanges'

    #    if !exists('g:airline_symbols')
    #        let g:airline_symbols = {}
    #    endif
    #
    #    let g:airline_symbols.dirty = " \U1f4c2"
    #    let g:airline_symbols.not_exists = " \Ufe0f"

    # Changes the working directory to the project root when you open a file
    # or directory
    # let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'Cargo.toml']

    # These aren't shipped by Nix, so they must be specified either here or in
    # a flake registry.
    sos-nvim = {
      url = "sos-nvim";
      flake = false;
    };

    github-nvim-theme = {
      url = "github-nvim-theme";
      flake = false;
    };

    telescope-paths-nvim = {
      url = "telescope-paths-nvim";
      flake = false;
    };
  };

  outputs = args @ {
    self,
    nixpkgs,
    flake-utils,
    sos-nvim,
    telescope-paths-nvim,
    github-nvim-theme,
    # vimrc,
    ...
  }: let
    fu = import flake-utils;
    inherit (nixpkgs) lib;
  in
    #{
    # neovim = import ./nvim.nix ({inherit nixpkgs;} // (import ./plugins.nix (args // {inherit nixpkgs;})));
    #}
    # // fu.eachSystem fu.allSystems (system:
    fu.eachSystem fu.allSystems (system:
      if
        lib.any (excl: excl == system) [
          "m68k-linux"
          "microblaze-linux"
          "microblazeel-linux"
          "powerpc64-linux"
          "riscv32-linux"
          "s390-linux"
          "s390x-linux"
        ]
      then {}
      else let
        nixpkgs = import args.nixpkgs {inherit system;};
        plugins = import ./plugins.nix (args // {inherit nixpkgs;});
      in {
        packages = rec {
          # plugins = import ./plugins.nix (args // {inherit nixpkgs;});
          # plugins = import ./plugins.nix (args // {inherit nixpkgs;});
          neovim = lib.makeOverridable import ./nvim.nix ({inherit nixpkgs;} // plugins);
          default = neovim;
        };
      });
  #     defaultPackage = _nixpkgs.lib.attrsets.genAttrs _nixpkgs.neovim.meta.platforms (system: let
  #       inherit (import args.nixpkgs {inherit system;}) lib neovim-unwrapped vimPlugins vimUtils wrapNeovimUnstable neovimUtils;
  #     in
  #       null);
}
