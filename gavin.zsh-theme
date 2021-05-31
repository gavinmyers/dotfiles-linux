PROMPT='%B%{$fg[green]%}|%{$reset_color%} ' 
RPROMPT='%~ $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%B%{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%B%{$fg[red]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ! %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"
