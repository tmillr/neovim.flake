{nixpkgs, ...} @ arg: let
  inherit (nixpkgs) vimPlugins vimUtils;
in {
  plugins = with vimPlugins; {
    sos-nvim = {
      plugin = vimUtils.buildVimPluginFrom2Nix {
        name = "sos-nvim";
        src = arg.sos-nvim;
      };
    };

    github-nvim-theme = {
      plugin = vimUtils.buildVimPluginFrom2Nix {
        name = "github-nvim-theme";
        src = arg.github-nvim-theme;
      };
    };

    telescope-paths-nvim = {
      plugin = vimUtils.buildVimPluginFrom2Nix {
        name = "telescope-paths-nvim";
        src = arg.telescope-paths-nvim;
      };
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
    plenary-nvim = {
      plugin = plenary-nvim;
    };
    which-key-nvim = {
      plugin = which-key-nvim;
    };
    vimwiki = {
      plugin = vimwiki;
    };
    commentary = {
      plugin = commentary;
    };
    gitsigns-nvim = {
      plugin = gitsigns-nvim;
    };
    rust-tools-nvim = {
      plugin = rust-tools-nvim;
    };
    nvim-dap = {
      plugin = nvim-dap;
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

    telescope-nvim = {
      plugin = telescope-nvim;
    };
    telescope-zf-native-nvim = {
      plugin = telescope-zf-native-nvim;
    };
    telescope-ui-select-nvim = {
      plugin = telescope-ui-select-nvim;
    };
  };
}
