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
  # Function that creates a wrapped neovim drv. Defined in
  # `pkgs/applications/editors/neovim/wrapper.nix`.
  # wrapNeovimUnstable,
  #
  # neovim-unwrapped,
  # neovimUtils,
  # vimPlugins,
  #
  # Merged with return val of `makeNeovimConfig` and passed to
  # `wrapNeovimUnstable`. `makeNeovimConfig` is a utility fn/constructor which
  # constructs the arguments to `wrapNeovimUnstable`.
  wrapNeovimConfig ? {wrapRc = false;},
  #
  # List of plugins
  plugins ? null,
  #
  # Plugins not in nixpkgs
  # customPlugins ? {},
  #
  extraLuaPackages ? null,
}:
nixpkgs.wrapNeovimUnstable nixpkgs.neovim-unwrapped (
  nixpkgs.neovimUtils.makeNeovimConfig {
    inherit extraLuaPackages;
    # customRC = lib.debug.traceVal vimrc;
    # see examples below how to use custom packages
    plugins = builtins.map (el: {optional = false;} // el) (
      if builtins.isList plugins
      then plugins
      else assert builtins.isAttrs plugins; builtins.attrValues plugins
    );
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
  // wrapNeovimConfig
)
