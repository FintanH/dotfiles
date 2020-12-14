{ pkgs, config, ... }:
let
  rc = builtins.readFile ./vim.rc;
in {
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
        configure.customRC = rc;
        configure.packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            coc-fzf
            coc-nvim
            ctrlp-vim
            fzf-vim # Fuzzy finder
            lightline-ale
            lightline-vim
            vim-highlightedyank
            vim-rooter # does a relative search in nearest git directory root
          ];
          opt = [
            coc-rust-analyzer
            coc-tslint
            agda-vim
            haskell-vim
            # vim-svelte-plugin # there's no svelte plugin
          ];
            };
          };
     })
  ];

  environment.variables = { EDITOR = "nvim"; };
  environment.systemPackages = with pkgs; [
    neovim
  ];
}
