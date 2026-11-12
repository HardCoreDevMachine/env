# Use Zsh's predictable emacs keymap.  Keep both common Backspace codes
# explicit: Windows terminals can emit either DEL (^?) or BS (^H).
bindkey -e
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char
