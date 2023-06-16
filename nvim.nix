# Example for converting to nix vimPlugin pkg
#
# easygrep = pkgs.vimUtils.buildVimPluginFrom2Nix {
#     name = "vim-easygrep";
#     src = pkgs.fetchFromGitHub {
#       owner = "dkprice";
#       repo = "vim-easygrep";
#       rev = "d0c36a77cc63c22648e792796b1815b44164653a";
#       hash = "sha256-bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=";
#     };
#   };
#
# neovimUtils.makeNeovimConfig: constructs arg to `wrapNeovimUnstable`
#
{
  nixpkgs,
  # Creates a wrapped neovim drv. Defined in `pkgs/applications/editors/neovim/wrapper.nixwrapper.nix`
  # wrapNeovimUnstable,
  # neovim-unwrapped,
  # neovimUtils,
  # vimPlugins,
  # Merged with return val of `makeNeovimConfig` and passed to `wrapNeovimUnstable`
  wrapNeovimConfig ? {wrapRc = false;},
  plugins ? null,
  # Plugins not in nixpkgs
  # customPlugins ? {},
}:
nixpkgs.wrapNeovimUnstable nixpkgs.neovim-unwrapped (nixpkgs.neovimUtils.makeNeovimConfig {
    # customRC = lib.debug.traceVal vimrc;
    # see examples below how to use custom packages
    inherit plugins;
    # plugins =
    #   plugins
    #   ++ nixpkgs.lib.attrsets.foldlAttrs (acc: k: v:
    #     acc
    #     ++ [
    #       (nixpkgs.vimUtils.buildVimPluginFrom2Nix {
    #         name = k;
    #         src = v;
    #       })
    #     ]) []
    #   customPlugins;
  }
  // wrapNeovimConfig)
