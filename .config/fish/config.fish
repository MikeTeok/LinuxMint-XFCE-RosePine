if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
fish_config theme choose "Rosé Pine Moon"
oh-my-posh init fish --config ~/.config/oh-my-posh/easy-term.omp.json | source
source ~/.aliases
export PATH="$HOME/Documents/StandaloneApp/nvim-linux-x86_64/bin:$PATH"

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/miketeok/.lmstudio/bin
# End of LM Studio CLI section

