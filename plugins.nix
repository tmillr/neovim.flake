arg: let
  inherit (arg) nixpkgs;
in {
  plugins = with nixpkgs.vimPlugins; [
    {
      plugin = nixpkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "sos-nvim";
        src = arg.sos-nvim;
      };
      optional = false;
      config = null;
    }
    {
      plugin = nixpkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "github-nvim-theme";
        src = arg.github-nvim-theme;
      };
      optional = false;
      config = null;
    }
    {
      plugin = nixpkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "telescope-paths-nvim";
        src = arg.telescope-paths-nvim;
      };
      optional = false;
      config = null;
    }
    {
      plugin = nvim-treesitter.withAllGrammars;
      optional = false;
      config = null;
    }
    {
      plugin = playground;
      optional = false;
      config = null;
    }
    {
      plugin = fugitive;
      optional = false;
      config = null;
    }
    {
      plugin = plenary-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = which-key-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = vimwiki;
      optional = false;
      config = null;
    }
    {
      plugin = commentary;
      optional = false;
      config = null;
    }
    {
      plugin = gitsigns-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = rust-tools-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = nvim-dap;
      optional = false;
      config = null;
    }
    {
      plugin = tabular;
      optional = false;
      config = null;
    }
    {
      plugin = markdown-preview-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = undotree;
      optional = false;
      config = null;
    }
    {
      plugin = octo-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = vim-snippets;
      optional = false;
      config = null;
    }
    {
      plugin = nvim-web-devicons;
      optional = false;
      config = null;
    }
    {
      plugin = vim-wakatime;
      optional = false;
      config = null;
    }
    {
      plugin = nvim-lspconfig;
      optional = false;
      config = null;
    }

    {
      # Snippet handler
      plugin = luasnip;
      optional = false;
      config = null;
    }
    {
      # Completion/Autocompletion handler (framework)
      plugin = nvim-cmp;
      optional = false;
      config = null;
    }

    # nvim-cmp sources
    {
      plugin = cmp-nvim-lsp;
      optional = false;
      config = null;
    }
    {
      plugin = cmp-nvim-lsp-signature-help;
      optional = false;
      config = null;
    }
    {
      plugin = cmp-buffer;
      optional = false;
      config = null;
    }
    {
      plugin = cmp-path;
      optional = false;
      config = null;
    }
    {
      plugin = cmp-cmdline;
      optional = false;
      config = null;
    }
    {
      plugin = cmp-git;
      optional = false;
      config = null;
    }
    {
      plugin = cmp-spell;
      optional = false;
      config = null;
    }
    {
      plugin = cmp_luasnip;
      optional = false;
      config = null;
    }

    {
      plugin = vim-airline;
      optional = false;
      config = null;
    }
    {
      plugin = vim-airline-themes;
      optional = false;
      config = null;
    }

    {
      plugin = telescope-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = telescope-zf-native-nvim;
      optional = false;
      config = null;
    }
    {
      plugin = telescope-ui-select-nvim;
      optional = false;
      config = null;
    }
  ];
}
