alias mplayer="mplayer -vo vdpau"
alias fixtime="sudo sh -c 'ntpd -qg && hwclock -w'"
alias l="ls -alh"

alias strip-underscores='for i in ./*; do mv -v -- "$i" "${i//_/ }"; done'
