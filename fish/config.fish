
if status is-interactive
    fish_add_path /home/$USER/.dotnet
    # Commands to run in interactive sessions can go here
    alias vim="nvim"
    alias nvimdiff="nvim -d"
    alias airpod_connect="bluetoothctl connect AC:C9:06:53:F9:1B"
    alias airpod_disconnect="bluetoothctl disconnect AC:C9:06:53:F9:1B"
    alias start_docker="sudo systemctl start docker"
    set _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on'

    function vim_cs -d "Print vim cheat sheet"
        w3m https://vim.rtorr.com/
    end
    function weather -d "Show today weather"
        curl v2d.wttr.in/Danang
    end
    fzf_configure_bindings --directory=\cf --git_log=\cg
    set fzf_fd_opts --hidden --exclude=.git --exclude=.vscode --exclude=.npm --exclude=.nvm --exclude=.nx --exclude=.mozilla
    if test "$(fgconsole)" = 1
        Hyprland
    end
    #if status is-interactive
    #and not set -q TMUX 
    #and test "$TERM" = "xterm-kitty"
    #    set TERM "xterm-256color"
    #    exec tmux new -As 0
    #end
end
