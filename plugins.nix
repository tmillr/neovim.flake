{vimPlugins}:
with vimPlugins; {
  sos-nvim = {
    plugin = sos-nvim;
  };
  github-nvim-theme = {
    plugin = github-nvim-theme;
  };
  telescope-paths-nvim = {
    plugin = telescope-paths-nvim;
  };
  one-small-step-for-vimkind = {
    plugin = one-small-step-for-vimkind;
  };

  nvim-treesitter = {
    plugin = nvim-treesitter.withAllGrammars;
  };
  playground = {
    plugin = playground;
  };
  fugitive = {
    plugin = fugitive;
  };
  vim-surround = {
    plugin = vim-surround;
  };
  vim-eunuch = {
    plugin = vim-eunuch;
  };
  plenary-nvim = {
    plugin = plenary-nvim;
  };
  nui-nvim = {
    plugin = nui-nvim;
  };
  which-key-nvim = {
    plugin = which-key-nvim;
  };
  vimwiki = {
    plugin = vimwiki;
  };
  # commentary = {
  #   plugin = commentary;
  # };
  gitsigns-nvim = {
    plugin = gitsigns-nvim;
  };
  rustaceanvim = {
    plugin = rustaceanvim;
  };
  nvim-dap = {
    plugin = nvim-dap;
  };
  nvim-dap-ui = {
    plugin = nvim-dap-ui;
  };
  nvim-dap-virtual-text = {
    plugin = nvim-dap-virtual-text;
  };
  tabular = {
    plugin = tabular;
  };
  markdown-preview-nvim = {
    plugin = markdown-preview-nvim;
  };
  undotree = {
    plugin = undotree;
  };
  octo-nvim = {
    plugin = octo-nvim;
  };
  vim-snippets = {
    plugin = vim-snippets;
  };
  nvim-web-devicons = {
    plugin = nvim-web-devicons;
  };
  vim-wakatime = {
    plugin = vim-wakatime;
  };
  nvim-lspconfig = {
    plugin = nvim-lspconfig;
  };

  luasnip = {
    # Snippet handler
    plugin = luasnip;
  };
  nvim-cmp = {
    # Completion/Autocompletion handler (framework)
    plugin = nvim-cmp;
  };

  # nvim-cmp sources
  cmp-nvim-lsp = {
    plugin = cmp-nvim-lsp;
  };
  cmp-nvim-lsp-signature-help = {
    plugin = cmp-nvim-lsp-signature-help;
  };
  cmp-buffer = {
    plugin = cmp-buffer;
  };
  cmp-path = {
    plugin = cmp-path;
  };
  cmp-cmdline = {
    plugin = cmp-cmdline;
  };
  cmp-git = {
    plugin = cmp-git;
  };
  cmp-spell = {
    plugin = cmp-spell;
  };
  cmp_luasnip = {
    plugin = cmp_luasnip;
  };

  vim-airline = {
    plugin = vim-airline;
  };
  vim-airline-themes = {
    plugin = vim-airline-themes;
  };

  # Telescope
  telescope-nvim = {
    plugin = telescope-nvim;
  };
  telescope-zf-native-nvim = {
    plugin = telescope-zf-native-nvim;
  };
  telescope-ui-select-nvim = {
    plugin = telescope-ui-select-nvim;
  };

  diffview-nvim = {
    plugin = diffview-nvim;
  };
}
