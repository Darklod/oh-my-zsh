# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black:16, red:1, green:41, yellow:220, blue:13, magenta, cyan:33, and white:15.
#
# Mar 2013 Yad Smood
# My Personal Costumization

# VCS
YS_VCS_PROMPT_PREFIX1=" (%{$FG[015]%}%{$reset_color%}"
YS_VCS_PROMPT_PREFIX2="%{$FG[033]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%})"
YS_VCS_PROMPT_DIRTY=" %{$FG[001]%}x"
YS_VCS_PROMPT_CLEAN=" %{$FG[041]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$FG[001]%}%?%{$reset_color%})"

# Prompt format:
#
# PRIVILEGES USER @ MACHINE : DIRECTORY BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp : ~/.oh-my-zsh master x [21:47:42] C:0
# $
PROMPT="
%{$terminfo[bold]$FG[033]%}#%{$reset_color%} \
%(#,%{$bg[220]%}%{$FG[016]%}%n%{$reset_color%},%{$FG[039]%}%n) \
%{$FG[015]%}@ \
%{$FG[041]%}%m \
%{$FG[015]%}: \
%{$terminfo[bold]$FG[220]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
%{$FG[015]%}[%*] $exit_code
%{$terminfo[bold]$FG[001]%}$ %{$reset_color%}"
