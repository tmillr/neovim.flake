# TODO: nvim config, bundle nvim?, rc script to set rtp etc. and/or load
# plugins, plugin black/white list or override mechanism, nvim HEAD install,
# ts parser path, docs outputs, check references, system setting
{
  description = "@tmillr's Neovim flake";

  inputs = {
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

    one-small-step-for-vimkind = {
      type = "github";
      owner = "jbyuki";
      repo = "one-small-step-for-vimkind";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    sos-nvim,
    telescope-paths-nvim,
    github-nvim-theme,
    one-small-step-for-vimkind,
  }: let
    inherit (builtins) attrValues isAttrs isList elem map;
    fu = import flake-utils;
  in
    #{
    # neovim = import ./nvim.nix ({inherit nixpkgs;} // (import ./plugins.nix (args // {inherit nixpkgs;})));
    #}
    # // fu.eachSystem fu.allSystems (system:
    #
    # NOTE: This could instead be mapped to nixpkgs.legacyPackages, or
    # nixpkgs.neovim.meta.platforms?
    fu.eachSystem fu.allSystems (system: let
      ignore = [
        "m68k-linux"
        "microblaze-linux"
        "microblazeel-linux"
        "powerpc64-linux"
        "riscv32-linux"
        "s390-linux"
        "s390x-linux"
      ];
    in
      nixpkgs.lib.optionalAttrs (!elem system ignore) {
        packages = {
          inherit
            (import nixpkgs {
              localSystem = system;
              overlays = with self.overlays; [plugins neovim];
            })
            neovim
            nbusted
            ;
          default = self.packages.${system}.neovim;
        };

        # lib = {
        #   writeNeovimScript = {
        #     neovim ? packages.neovim,
        #     vimrc ? "NONE",
        #     shada ? false,
        #     swap ? false,
        #     lua ? null,
        #     llua ? null,
        #   }:
        #     assert lua == null || llua == null;
        #       name:
        #         writeShellScriptBin name
        #         ''
        #           exec ${lib.getBin neovim}/bin/nvim \
        #             ${builtins.concatStringsSep " \\\n  " ([
        #               "-u ${vimrc}"
        #             ]
        #             ++ lib.optional shada "-i NONE"
        #             ++ lib.optional (!swap) "-n"
        #             ++ lib.optional (lua != null) lua
        #             ++ lib.optional (llua != null) llua)}
        #         '';
        # };

        # checks = {
        #   check-queries = self.packages.${system}.neovim.plugins.nvim-treesitter.plugin.passthru.tests.check-queries.overrideAttrs (_: {
        #     nativeBuildInputs = [self.packages.${system}.neovim];
        #   });
        # };
      })
    // {
      overlays = {
        plugins = final: prev: {
          vimPlugins = prev.vimPlugins.extend (final': prev': {
            sos-nvim = final.vimUtils.buildVimPlugin {
              name = "sos-nvim";
              src = sos-nvim;
            };
            github-nvim-theme = final.vimUtils.buildVimPlugin {
              name = "github-nvim-theme";
              src = github-nvim-theme;
            };
            telescope-paths-nvim = final.vimUtils.buildVimPlugin {
              name = "telescope-paths-nvim";
              src = telescope-paths-nvim;
              dependencies = with final'; [plenary-nvim telescope-nvim];
            };
            one-small-step-for-vimkind = final.vimUtils.buildVimPlugin {
              name = "one-small-step-for-vimkind";
              src = one-small-step-for-vimkind;
            };
          });
        };

        neovim = final: prev: let
          inherit (final) neovimUtils lib;
          plugins' = import ./plugins.nix {inherit (final.pkgsHostTarget) vimPlugins;};
          plugins = map (el: {optional = false;} // el) (
            if isList plugins'
            then plugins'
            else assert isAttrs plugins'; attrValues plugins'
          );

          neovimConfig = {
            wrapRc = false;
            extraLuaPackages = luapkgs:
              with luapkgs; [
                lpeg
                busted
                middleclass
                tiktoken_core
              ];
          };

          wrapperConfig = lib.makeOverridable neovimUtils.makeNeovimConfig (neovimConfig
            // {
              inherit plugins;
            });
        in {
          neovim =
            (final.wrapNeovimUnstable
              final.neovim-unwrapped
              wrapperConfig)
            # (lib.traceValSeq wrapperConfig))
            .overrideAttrs (prev: {
              # Use passthru for plugins, because overriding it doesn't cause
              # a proper rebuild.
              passthru = prev.passthru or {} // {inherit plugins wrapperConfig;};
            });

          nbusted = let
            lua = ''
              assert(
                  coroutine.resume(
                      coroutine.create(function()
                          return require 'busted.runner' { standalone = false }
                      end)
                  )
              )
            '';
          in
            final.writeShellScriptBin "nbusted"
            ''
              exec ${lib.getExe final.neovim} \
                  -u NONE \
                  -i NONE \
                  -n \
                  --headless \
                  '+=require("busted.runner")({ standalone = false })'
            '';
        };

        default = self.overlays.neovim;
      };

      lib = import ./lib.nix nixpkgs;
    };
}
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
