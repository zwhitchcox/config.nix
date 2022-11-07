{ config, pkgs, lib, ... }:
# Let-In ----------------------------------------------------------------------------------------{{{
let
  inherit (lib) optional;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;

  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });

  session-lens = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "session-lens";
    version = "2022-09-05";
    src = pkgs.fetchFromGitHub {
      owner = "rmagatti";
      repo = "session-lens";
      rev = "103a45dfedc23fa6bac48dc8cdcd62fa9f98ac0c";
      sha256="sha256-MFBWT8EuH7KhdXR4hDRuz+p0GGSJTJCbf7d/LBvKZSI=";
    };
  };
  my-auto-session = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "auto-session";
    version = "2021-09-05";
    src = ./myas;
    # src = pkgs.fetchFromGitHub {
    #   owner = "rmagatti";
    #   repo = "auto-session";
    #   rev = "b9b9b9b9b9b9b9b9b9b9b9b9b9b9b9b9b9b9b9b9b";
    #   sha256="sha256-MFBWT8EuH7KhdXR4hDRuz+p0GGSJTJCbf7d/LBvKZSI=";
    # };
  };

  nonVSCodePluginWithConfig = plugin: {
    inherit plugin;
    optional = true;
    config = ''
      if !exists('g:vscode')
        lua require('user.' .. string.gsub('${plugin.pname}', '%.', '-'))
      endif
    '';
  };

  nonVSCodePlugin = plugin: {
    inherit plugin;
    optional = true;
    config = ''
      if !exists('g:vscode') | packadd ${plugin.pname} | endif
    '';
  };
in
# }}}
{
  # Neovim
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim.enable = true;

  # Config and plugins ------------------------------------------------------------------------- {{{

  # Minimal init.vim config to load Lua config. Nix and Home Manager don't currently support
  # `init.lua`.
  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim/lua";
  xdg.configFile."nvim/pack/dev/opt".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim/plugins";
  xdg.configFile."nvim/colors".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim/colors";
  programs.neovim.extraConfig = "lua require('init')";

  programs.neovim.extraLuaPackages = [ pkgs.lua51Packages.penlight ];

  home.packages = with pkgs; [
    ripgrep # for telescope text search
    cmake-language-server # for ccls

  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    lush-nvim
    tabular
    vim-commentary
    vim-eunuch
    vim-haskell-module-name
    vim-surround


  ] ++ map (p: { plugin = p; optional = true; }) [
    nvim-ts-rainbow # rainbow parentheses
  ] ++ map nonVSCodePlugin [
    tokyonight-nvim
    copilot-vim
    direnv-vim
    goyo-vim
    vim-fugitive
    impatient-nvim
    plenary-nvim
    vim-bbye
  ] ++ map nonVSCodePluginWithConfig [
    # my-auto-session
    neoscroll-nvim
    which-key-nvim
    nvim-tree-lua
    editorconfig-vim
    (pluginWithDeps galaxyline-nvim [ nvim-web-devicons ])
    gitsigns-nvim
    indent-blankline-nvim
    lsp_lines-nvim
    lspsaga-nvim
    (pluginWithDeps bufferline-nvim [ nvim-web-devicons ])
    null-ls-nvim
    nvim-lastplace
    nvim-lspconfig
    (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars ++ [
    ]))
    (pluginWithDeps telescope-nvim [
      nvim-web-devicons
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-symbols-nvim
      telescope-zoxide
      telescope-ui-select-nvim
    ])
    toggleterm-nvim
    # vim-pencil
    vim-polyglot
  ];

  # From personal addon module `../modules/home/programs/neovim/extras.nix`
  programs.neovim.extras.termBufferAutoChangeDir = true;
  programs.neovim.extras.nvrAliases.enable = true;
  # }}}

  # Required packages -------------------------------------------------------------------------- {{{

  programs.neovim.extraPackages = with pkgs; [
    neovim-remote

    # Language servers, linters, etc.
    # See `../configs/nvim/lua/malo/nvim-lspconfig.lua` and
    # `../configs/nvim/lua/malo/null-ls-nvim.lua` for configuration.

    # C/C++/Objective-C
    ccls

    # Bash
    nodePackages.bash-language-server
    shellcheck

    # Javascript/Typescript
    nodePackages.typescript-language-server

    # Nix
    deadnix
    statix
    rnix-lsp

    # Python
    black
    # isort
    # pylint
    pyright

    # Vim
    nodePackages.vim-language-server

    #Other
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    proselint
    sumneko-lua-language-server
  ];
  # }}}
}
# vim: foldmethod=marker
