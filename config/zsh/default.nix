{pkgs, lib, ...}:
{
  home.file = {
    ".p10k.zsh".source = ./p10k.zsh;
  };
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd"] ;
  };
  programs.zsh =
  {
    enable = true;
    shellAliases  = {
      ".." = "cd ..";
      "la" = "ls -a";
      "y" = "yazi";
      "cdd" = "cd $HOME/Documents";
      # "spotifyrtp" = "pactl load-module module-rtp-send source=spotify.monitor";
    };
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["direnv" "fzf" "git" "git-auto-fetch" "copybuffer" "history"];
    };
    initContent = let after = lib.mkOrder 1600 "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"; before = lib.mkOrder 400 (''
      DISABLE_AUTO_UPDATE="true"
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme'');
      in lib.mkMerge [before after];
  };

  # programs.thefuck.enable = true;
  programs.dircolors = {
    enable = true;
    settings = {
      OTHER_WRITABLE = "30;42";
    };
  };
}
