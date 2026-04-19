#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fastfetch

alias ls='ls --color=auto'

alias key='cat << "EOF"
╔══════════════════════════════════════════════════════╗
║              HYPRLAND KEYBINDINGS                    ║
╠══════════════════════════════════════════════════════╣
║  APPS                                                ║
║  Super + Q        Open terminal (kitty)              ║
║  Super + E        Open file manager (thunar)         ║
║  Super + R        App launcher (walker)              ║
║  Super + V        Clipboard history picker           ║
║                                                      ║
║  WINDOWS                                             ║
║  Super + C        Close focused window               ║
║  Ctrl + X         Close focused window               ║
║  Super + F        Toggle floating window             ║
║  Super + P        Toggle pseudo-tile                 ║
║  Super + J        Toggle split direction             ║
║  Super + Arrows   Move focus between windows         ║
║  Super + LMB      Drag to move window                ║
║  Super + RMB      Drag to resize window              ║
║                                                      ║
║  WORKSPACES                                          ║
║  Super + 1-5      Philips 4K workspaces              ║
║  Super + 6-0      Samsung workspaces                 ║
║  Super + Shift + 1-0  Move window to workspace       ║
║  Super + S        Toggle scratchpad workspace        ║
║  Super + Shift+S  Move window to scratchpad          ║
║  Super + Scroll   Cycle workspaces                   ║
║                                                      ║
║  SYSTEM                                              ║
║  Super + M        Log out / exit Hyprland            ║
║  Volume Up/Down   Keyboard media keys                ║
║  Brightness Up/Down  Keyboard brightness keys        ║
║  Play/Pause/Next/Prev  Media keys                    ║
╚══════════════════════════════════════════════════════╝
EOF'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$HOME/.claude/bin:$PATH"
alias matrix='cmatrix -b -C blue'
alias config='nano ~/.config/hypr/hyprland.conf'
