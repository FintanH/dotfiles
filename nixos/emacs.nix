/*
This is a nix expression to build Emacs and some Emacs packages I like
from source on any distribution where Nix is installed. This will install
all the dependencies from the nixpkgs repository and build the binary files
without interfering with the host distribution.
*/
{ pkgs ? import <nixpkgs> {} }:
let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    adoc-mode
    company
    direnv
    lsp-mode
    lsp-ui
    magit          # ; Integrate git <C-x g>
    nix-haskell-mode
    projectile
    projectile-ripgrep
    yasnippet
    flycheck
  ]) ++ (with epkgs.melpaPackages; [
    lsp-haskell
    monokai-theme
    nix-sandbox
    rustic
  ]) ++ (with epkgs.elpaPackages; [
    beacon         # ; highlight my cursor when scrolling
    nameless       # ; hide current package name everywhere in elisp code
  ]) ++ [
    pkgs.notmuch   # From main packages set
  ])
