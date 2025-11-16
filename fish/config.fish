if status is-interactive
    fish_add_path /home/$USER/.dotnet
    # Commands to run in interactive sessions can go here
    alias vim="nvim"
    alias ls="eza"
    alias nvimdiff="nvim -d"
    alias airpod_connect="bluetoothctl connect AC:C9:06:53:F9:1B"
    alias airpod_disconnect="bluetoothctl disconnect AC:C9:06:53:F9:1B"
    alias start_docker="sudo systemctl start docker"
    alias uvm="uv run main.py"
    alias icat="kitten icat"
    set _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on'
    set DOTNET_ROOT "$HOME/.dotnet"

    function vim_cs -d "Print vim cheat sheet"
        w3m https://vim.rtorr.com/
    end
    function weather -d "Show today weather"
        curl v2d.wttr.in/Danang
    end
    function start_sts_vpn -d "Connect to STS networks"
        systemctl start forticlient
        forticlient gui
    end
    function code_snip -d "Generate code snippet from a description"
        agentcrew job --agent-config="~/.AgentCrew/agents-auto.toml" --agent="CodeSnipper" --provider=deepinfra --model-id="deepseek-ai/DeepSeek-V3.1-Terminus" "$argv"
    end
    fzf_configure_bindings --directory=\cf --git_log=\cg
    set fzf_fd_opts --hidden --exclude=.git --exclude=.vscode --exclude=.npm --exclude=.nvm --exclude=.nx --exclude=.mozilla
    #if status is-interactive
    #and not set -q TMUX 
    #and test "$TERM" = "xterm-kitty"
    #    set TERM "xterm-256color"
    #    exec tmux new -As 0
    #end
end

# uv
fish_add_path "/home/quytruong/.local/bin"
. $HOME/.fishrc
