#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi


#nohup redshift > /dev/null &


## Input
ibus-daemon --xim &
xset m 0 0 # Disable mouse acceleration


## Audio
export SDL_AUDIODRIVER=pulseaudio

if [ -f $HOME/.jackrc ]; then
	sh $HOME/.jackrc > $HOME/.jackd.log 2>&1 &
fi

## Start WM
wmname LG3D
~/.lightson 295 &
/usr/bin/xscreensaver -no-splash &
/etc/X11/Xsession
nitrogen --restore
gpuush -background &
exec awesome --no-argb

