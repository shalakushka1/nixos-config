{ config, pkgs, ... }: {

programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    history = {
      size = 5000;
      save = 5000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreSpace = true;
      ignoreAllDups = true;
      share = true;
    };
    
    shellAliases = {
      ls = "ls --color";
      vim = "nvim";
      c = "clear";
      sudoedit = "doasedit";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "command-not-found" ];
    };

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "zsh-completions";
        src = "${pkgs.zsh-completions}/share/zsh-completions";
      }
    ];

    initContent = ''
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region
      bindkey "^[[3~" delete-char

      setopt appendhistory
      setopt hist_ignore_dups
      setopt hist_find_no_dups
      setopt hist_save_no_dups

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
    '';
  };

programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

}
