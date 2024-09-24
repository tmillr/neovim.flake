{lib, ...}:
with builtins; rec {
  fixupPlugins = {
    pluginDeps ? [],
    filterPlugins ? [],
    ...
  }: plugins: let
    old = removeAttrs (toAttrs plugins) filterPlugins;
    deps = toAttrs pluginDeps;
    normalize = p:
      if (p ? plugin)
      then p
      else {plugin = p;};
    toAttrs = plugins: let
      plugins' = map normalize plugins;
    in
      lib.throwIfNot
      (lib.allUnique (map (p: lib.getName p.plugin) plugins')) "duplicated plugins"
      listToAttrs (map (p: {
          name = lib.getName p.plugin;
          value = p;
        })
        plugins');
  in
    attrValues (lib.recursiveUpdateUntil (path: l: r: lib.last path == "plugin") old deps);

  fixupLuaPackages = luaDeps: f: lpkgs: let
    names = map (dep: lib.getName dep) deps;
    deps =
      if isFunction luaDeps
      then luaDeps lpkgs
      else luaDeps;
  in
    filter (pkg: !(elem (lib.getName pkg) names)) (f lpkgs) ++ deps;

  # Make a neovim for to be used for both editing and for developing a
  # particular plugin (live usage/feedback while editing). Accepts a
  # wrapped/custom neovim and overrides it in order to inject deps, filter
  # out duplicate plugins/deps, etc.
  nvimForPluginDev = {
    pluginDeps ? [],
    # List of pname's of plugins to remove completely (including their
    # config). Main use-case is to filter out the plugin being developed on
    # (in-case the developer already has it installed) so that there are not
    # duplicates at runtime.
    filterPlugins ? [],
    luaDeps ? (_: []),
    wrapperArgs ? "",
  } @ arg: neovim: let
    makeNeovimConfigAttrsArg = {
      plugins ? [],
      extraLuaPackages ? (_: []),
      ...
    }: {
      plugins = fixupPlugins arg plugins;
      extraLuaPackages = fixupLuaPackages luaDeps extraLuaPackages;
    };

    wrapperAttrsArg = oa: {
      wrapperArgs = lib.pipe [oa.wrapperArgs wrapperArgs] [
        (map (wa:
          if isList wa
          then lib.escapeShellArgs wa
          else wa))
        (concatStringsSep " ")
      ];
    };
  in
    (neovim.override (oa: oa.override makeNeovimConfigAttrsArg)).override wrapperAttrsArg;
}
