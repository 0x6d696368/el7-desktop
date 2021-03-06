#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y update
sudo yum -y install deltarpm epel-release
sudo yum -y groupinstall "X Window System"
sudo yum -y install i3 i3lock i3status lightdm rxvt-unicode gnome-terminal dejavu-*fonts NetworkManager NetworkManager-wifi NetworkManager-openvpn network-manager-applet NetworkManager-openvpn-gnome NetworkManager-tui xdotool xwd netpbm-progs xorg-x11-server-utils gnome-screenshot
sudo systemctl set-default graphical.target # boots to i3 by default
# sudo systemctl isolate graphical.target # starts i3 from terminal

# COPY CONFIGURATION FILES
mkdir -p /home
mkdir -p /home/user
mkdir -p ~/.i3
mkdir -p ~/.gnupg
mkdir -p ~/screencast
mkdir -p ~/.config
mkdir -p ~/.local
mkdir -p ~/.local/share
mkdir -p ~/.local/share/applications
mkdir -p /etc
mkdir -p /etc/X11
mkdir -p /etc/X11/xorg.conf.d
mkdir -p /etc/udev
mkdir -p /etc/udev/rules.d
cat > ~/.i3/i3status.conf << PASTECONFIGURATIONFILE
# i3status configuration file.
# see "man i3status" for documentation.

# It is important that this file is edited as UTF-8.
# The following line should contain a sharp s:
# ß
# If the above line is not correctly displayed, fix your editor first!

general {
        colors = true
        interval = 5
}

# order += "ipv6"
order += "disk /"
order += "run_watch DHCP"
# order += "run_watch VPN"
order += "wireless _first_"
order += "ethernet _first_"
order += "battery 1"
order += "load"
order += "tztime local"
order += "tztime utc"
order += "volume master"

wireless _first_ {
        # format_up = "W: (%quality at %essid) %ip"
	#format_up = "%quality %essid %ip"
	format_up = "%quality %essid"
        # format_down = "W: down"
        format_down = "wifi"
}

ethernet _first_ {
        # if you use %speed, i3status requires root privileges
        # format_up = "E: %ip (%speed)"
	format_up = "eth %ip"
        # format_down = "E: down"
        format_down = "eth"
}

battery 1 {
        format = "%status %percentage %remaining"
}

run_watch DHCP {
        pidfile = "/var/run/dhclient*.pid"
	format = "dhcp"
}

run_watch VPN {
        pidfile = "/var/run/vpnc/pid"
}

tztime local {
        #format = "%Y%m%dT%H%M%z"
        format = "%z"
}

tztime utc {
        #format = "%Y%m%dT%H%M%S"
        format = "%Y%m%dT%H%M"
	timezone = "UTC"
}

load {
    format = "%1min,%5min,%15min"
}

disk "/" {
        format = "%free"
}

volume master {
        format = ">%volume"
        device = "default"
        mixer = "Master"
        mixer_idx = 0
}

#brightness {
#	max = "/sys/class/backlight/intel_backlight/max_brightness"
#	cur = "/sys/class/backlight/intel_backlight/brightness"
#	txt = "*"
#}

PASTECONFIGURATIONFILE
base64 -d > ~/.i3/lock.png << PASTECONFIGURATIONFILE
iVBORw0KGgoAAAANSUhEUgAAAGQAAAAyCAYAAACqNX6+AAABqklEQVR42u2Zz0qUURiHnxFFvQYX
4hCB06KFC1sF0kXUqqiFeAWCFF1AuvAG7EIkb0BbGITB1CKEbB3kn92vzREOH9+nI7hw8nmGd3HO
O/OemfN833mZmR4Q5M4w4RYoRBSiEFGIQkQhChGFKETGVkjXjyyTwAfgpMRmmat5DRwCp8B34FVH
3QEwBNaqXDNo5M6BI2Dj/7jEMnKkY/4dYZcwV2KP8LbKrxIOCU8IM4Q+4WNL3RXCkPB0hDXr3Gyp
/ZmwfoPPczfjFoQMCYvV+FGZuxx/JSxdU/cl4YAwP+KabbnHhG8KCWeE6Wo8TTitxn/LVXxV3T+E
5x255qPr/cw21h3DuJ0T9xfQr8YPytwlP0tvuIpnwDbwoiXXa0QXD4Fje0h43+ghnzp6yHK5e/qE
nZa6A8Jxef5Ne8gyYf8+9pC242OKsEX4TTghbBImG699Q/hSjpRh6Rltm75A+FFt7HVHVggXhCPC
BmFivIX08B9DvxiKQhQiClGIKEQhohCFiEJEIQoRhShEFKIQUYhCRCGiEIWIQhQiClGIKEQhohBR
iEJEIePMP21JUcdoUW35AAAAAElFTkSuQmCC
PASTECONFIGURATIONFILE
cat > ~/.i3/brightness.sh << PASTECONFIGURATIONFILE
expr \\( \$(cat /sys/class/backlight/intel_backlight/brightness) \\* 100 \\) \\/ \\( \$(cat /sys/class/backlight/intel_backlight/max_brightness) \\* 1 \\)
PASTECONFIGURATIONFILE
cat > ~/.i3/i3status.sh << PASTECONFIGURATIONFILE
#!/bin/sh
# shell script to prepend i3status with more stuff

i3status -c ~/.i3/i3status.conf | while :
do
        read line
	brightness=\$(expr \\( \$(cat /sys/class/backlight/intel_backlight/brightness) \\* 100 \\) \\/ \\( \$(cat /sys/class/backlight/intel_backlight/max_brightness) \\* 1 \\))
        echo "\$line | \${brightness}" || exit 1
done
PASTECONFIGURATIONFILE
cat > ~/.i3/pngofwindow.sh << PASTECONFIGURATIONFILE
#!/bin/bash
# old heavy version depending on imagemagick
#import -window \`xdotool getactivewindow\` "~/screenshot_\$(xdotool getwindowname \`xdotool getactivewindow\`)_\$(date +%Y%m%dT%H%M%S%z).png"
xwid=\$(xdotool getactivewindow)
windowname=\$(xdotool getwindowname "\${xwid}" | sed 's/[^A-Za-z0-9]/_/g')
#xwd -frame -silent -id "\${xwid}" | xwdtopnm | pnmtopng > "\$(cat ~/.globalpwd)/screenshot_\${windowname}_\$(date +%Y%m%dT%H%M%S%z).png"
# new with gnome-screenshot
gnome-screenshot -w -f "\$(cat ~/.globalpwd)/screenshot_\${windowname}_\$(date +%Y%m%dT%H%M%S%z).png"
PASTECONFIGURATIONFILE
cat > ~/.i3/pngofscreen.sh << PASTECONFIGURATIONFILE
#!/bin/bash
# old heavy version depending on imagemagick
import -window root "\$(cat ~/.globalpwd)/screenshot_\$(date +%Y%m%dT%H%M%S%z).png"
# new slimmer version does not work: https://github.com/i3/i3/issues/2435
#xwd -silent -name root | xwdtopnm | pnmtopng > "\$(cat ~/.globalpwd)/screenshot_\$(date +%Y%m%dT%H%M%S%z).png"
PASTECONFIGURATIONFILE
cat > ~/.i3/config << PASTECONFIGURATIONFILE
# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout somewhen, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

# HINT: get keysym names via \`xev\`


set \$mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:DejaVu Sans Mono 7
#font -*-fixed-*-*-*-*-10-*-*-*-*-*-*-*

# Use Mouse+\$mod to drag floating windows to their wanted position
#floating_modifier \$mod

# start a terminal
bindsym \$mod+Return exec i3-sensible-terminal

# kill focused window
bindsym \$mod+Shift+q kill

# start dmenu (a program launcher)
# bindsym \$mod+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
bindsym \$mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym \$mod+j focus left
bindsym \$mod+k focus down
bindsym \$mod+l focus up
bindsym \$mod+semicolon focus right

# alternatively, you can use the cursor keys:
bindsym \$mod+Left focus left
bindsym \$mod+Down focus down
bindsym \$mod+Up focus up
bindsym \$mod+Right focus right

# move focused window
bindsym \$mod+Shift+j move left
bindsym \$mod+Shift+k move down
bindsym \$mod+Shift+l move up
bindsym \$mod+Shift+semicolon move right

# alternatively, you can use the cursor keys:
bindsym \$mod+Shift+Left move left
bindsym \$mod+Shift+Down move down
bindsym \$mod+Shift+Up move up
bindsym \$mod+Shift+Right move right

# split in horizontal orientation
bindsym \$mod+h split h

# split in vertical orientation
bindsym \$mod+v split v

# enter fullscreen mode for the focused container
bindsym \$mod+f fullscreen

# change container layout (stacked, tabbed, toggle split)
bindsym \$mod+s layout stacking
bindsym \$mod+w layout tabbed
bindsym \$mod+e layout toggle split

# toggle tiling / floating
bindsym \$mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym \$mod+space focus mode_toggle

# focus the parent container
bindsym \$mod+a focus parent

# focus the child container
bindsym \$mod+z focus child

# switch to workspace
bindsym \$mod+1 workspace 1
bindsym \$mod+2 workspace 2
bindsym \$mod+3 workspace 3
bindsym \$mod+4 workspace 4
bindsym \$mod+5 workspace 5
bindsym \$mod+6 workspace 6
bindsym \$mod+7 workspace 7
bindsym \$mod+8 workspace 8
bindsym \$mod+9 workspace 9
bindsym \$mod+0 workspace 10
bindsym \$mod+minus workspace 11
bindsym \$mod+equal workspace 12
bindsym \$mod+BackSpace workspace 13

# move focused container to workspace
bindsym \$mod+Shift+1 move container to workspace 1
bindsym \$mod+Shift+2 move container to workspace 2
bindsym \$mod+Shift+3 move container to workspace 3
bindsym \$mod+Shift+4 move container to workspace 4
bindsym \$mod+Shift+5 move container to workspace 5
bindsym \$mod+Shift+6 move container to workspace 6
bindsym \$mod+Shift+7 move container to workspace 7
bindsym \$mod+Shift+8 move container to workspace 8
bindsym \$mod+Shift+9 move container to workspace 9
bindsym \$mod+Shift+0 move container to workspace 10
bindsym \$mod+Shift+minus move container to workspace 11
bindsym \$mod+Shift+equal move container to workspace 12
bindsym \$mod+Shift+BackSpace move container to workspace 13

# reload the configuration file
bindsym \$mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym \$mod+Shift+r restart

# exit i3 (logs you out of your X session)
# bindsym \$mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
#bindsym \$mod+Shift+e exec "i3-nagbar -t warning -m 'What should I do?' -b 'Power-off' 'systemctl poweroff' -b 'Suspend' 'systemctl suspend' -b 'Hibernate' 'systemctl hibernate' -b 'Reboot' 'systemctl reboot' -b 'Logout' 'i3-msg exit'

set \$exit "Exit? [p]oweroff [r]eboot [s]uspend [h]ibernate [l]ock log[o]out"

mode \$exit {
	bindsym p exec i3lock -i ~/.i3/lock.png -t && systemctl poweroff, mode "default"
	bindsym r exec i3lock -i ~/.i3/lock.png -t && systemctl reboot, mode "default"
	bindsym s exec i3lock -i ~/.i3/lock.png -t && systemctl suspend, mode "default"
	bindsym h exec i3lock -i ~/.i3/lock.png -t && systemctl hibernate, mode "default"
	bindsym o exec i3lock -i ~/.i3/lock.png -t && i3-msg exit, mode "default"
	bindsym l exec i3lock -i ~/.i3/lock.png -t, mode "default"

        # back to normal: Escape
        bindsym Escape mode "default"	
}

bindsym \$mod+Escape mode \$exit


# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt
        bindsym Shift+j resize shrink width 1 px or 1 ppt
        bindsym Shift+k resize grow height 1 px or 1 ppt
        bindsym Shift+l resize shrink height 1 px or 1 ppt
        bindsym Shift+semicolon resize grow width 1 px or 1 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt
        bindsym Shift+Left resize shrink width 1 px or 1 ppt
        bindsym Shift+Down resize grow height 1 px or 1 ppt
        bindsym Shift+Up resize shrink height 1 px or 1 ppt
        bindsym Shift+Right resize grow width 1 px or 1 ppt

        # back to normal: Escape
        bindsym Escape mode "default"
}

bindsym \$mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
	tray_output LVDS1
	status_command i3status -c ~/.i3/i3status.conf
	#TODO: the following has no colors :(
	#status_command ~/.i3/i3status.sh
}

# get brightness
bindsym \$mod+b exec i3-nagbar -m "Display brightness: \$(expr \\( \$(cat /sys/class/backlight/intel_backlight/brightness) \\* 100 \\) \\/ \\( \$(cat /sys/class/backlight/intel_backlight/max_brightness) \\* 1 \\)) %"

bindsym \$mod+Ctrl+l exec i3lock -i ~/.i3/lock.png -t

bindsym \$mod+n move workspace to output left
bindsym \$mod+Shift+n move container to output left
bindsym \$mod+m move workspace to output up
bindsym \$mod+Shift+m move container to output up

#bindsym \$mod+o exec xrandr --output LVDS1 --auto
bindsym \$mod+o exec xrandr --output LVDS1 --auto --output VGA1 --mode 1920x1080 --above LVDS1
bindsym \$mod+Shift+o exec xrandr --output LVDS1 --auto --output VGA1 --off

bindsym XF86AudioRaiseVolume exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '+1%'
bindsym Shift+XF86AudioRaiseVolume exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '+10%'
bindsym XF86AudioLowerVolume exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '-1%'
bindsym Shift+XF86AudioLowerVolume exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '-10%'
bindsym XF86AudioMute exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '0%'
bindsym \$mod+F6 exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '+1%'
bindsym \$mod+Shift+F6 exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '+10%'
bindsym \$mod+F5 exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '-1%'
bindsym \$mod+Shift+F5 exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '-10%'
bindsym \$mod+F4 exec /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ '0%'

bindsym XF86MonBrightnessUp exec xbacklight -inc 1 # increase screen brightness
bindsym Shift+XF86MonBrightnessUp exec xbacklight -set 100 # set max birghtness
bindsym XF86MonBrightnessDown exec xbacklight -dec 1 # decrease screen brightness
bindsym Shift+XF86MonBrightnessDown exec xbacklight -set 1 # set min brightness
bindsym \$mod+F2 exec xbacklight -inc 1 # increase screen brightness
bindsym \$mod+Shift+F2 exec xbacklight -set 100 # set max birghtness
bindsym \$mod+F1 exec xbacklight -dec 1 # decrease screen brightness
bindsym \$mod+Shift+F1 exec xbacklight -set 1 # set min brightness

bindsym \$mod+p exec "~/.i3/pngofselection.sh"
bindsym \$mod+Shift+p exec "~/.i3/pngofwindow.sh"
bindsym \$mod+Ctrl+p exec "~/.i3/pngofscreens.sh"

# set X11 background to dark green
exec_always --no-startup-id xsetroot -solid "#001100"

exec --no-startu-id gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"
exec --no-startu-id gsettings set org.gnome.nm-applet disable-connected-notifications "true"

exec --no-startup-id nm-applet
exec --no-startup-id /usr/libexec/polkit-gnome-authentication-agent-1
exec --no-startup-id dispwin ~/.i3/display.icc

exec_always --no-startup-id xsetwacom --set 10 area 246 36 3959 3846

for_window [class="Microsoft Teams - Preview" title="Microsoft Teams Notification"] floating enable

PASTECONFIGURATIONFILE
cat > ~/.i3/pngofselection.sh << PASTECONFIGURATIONFILE
#!/bin/bash
xwid=\$(xdotool getactivewindow)
windowname=\$(xdotool getwindowname "\${xwid}" | sed 's/[^A-Za-z0-9]/_/g')
gnome-screenshot -a -f "\$(cat ~/.globalpwd)/screenshot_\${windowname}_\$(date +%Y%m%dT%H%M%S%z).png"
PASTECONFIGURATIONFILE
cat > ~/.i3/pngofscreens.sh << PASTECONFIGURATIONFILE
#!/bin/bash
# old heavy version depending on imagemagick
#import -window root "\$(cat ~/.globalpwd)/screenshot_\$(date +%Y%m%dT%H%M%S%z).png"
# new slimmer version does not work: https://github.com/i3/i3/issues/2435
#xwd -silent -name root | xwdtopnm | pnmtopng > "\$(cat ~/.globalpwd)/screenshot_\$(date +%Y%m%dT%H%M%S%z).png"
# new gnome-screenshot version
gnome-screenshot -f "\$(cat ~/.globalpwd)/screenshot_\$(date +%Y%m%dT%H%M%S%z).png"
PASTECONFIGURATIONFILE
cat > ~/.i3/lock.sh << PASTECONFIGURATIONFILE
#!/bin/bash
import -window root /tmp/screenlock.png
i3lock -p win -i /tmp/screenlock.png  -d -u
rm /tmp/screenlock.png
PASTECONFIGURATIONFILE
cat > ~/.gnupg/gpg.conf << PASTECONFIGURATIONFILE
default-key 12345678
personal-digest-preferences SHA512
cert-digest-algo SHA512
digest-algo SHA512
cipher-algo AES256
default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
no-version
keyid-format 0xLONG
use-agent
force-mdc
disable-cipher-algo 3DES CAST5 
#weak-digest 
PASTECONFIGURATIONFILE
cat > ~/.gnupg/gpg-agent.conf << PASTECONFIGURATIONFILE
# GPGConf disabled this option here at Mon Mar 11 03:41:39 2019 CET
# default-cache-ttl 60
# GPGConf disabled this option here at Mon Mar 11 03:41:39 2019 CET
# max-cache-ttl 600

###+++--- GPGConf ---+++###
default-cache-ttl 300
max-cache-ttl 3000
###+++--- GPGConf ---+++### Mon Mar 11 03:41:39 2019 CET
# GPGConf edited this configuration file.
# It will disable options before this marked block, but it will
# never change anything below these lines.
PASTECONFIGURATIONFILE
cat > ~/.bashrc << PASTECONFIGURATIONFILE
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# START awesome prompt

# prompt will look like:
# [<exit_code> <time> <history #> <command #> <user>@<host> <path>
# <\$(user)|#(root)> ...


get_time() {
	echo \$(TZ=UTC date +%Y%m%dT%H%M%S%z)
}

get_exit() {
	if [[ \$1 == '0' ]]
	then
		echo -e "\\e[32m\$1\\e[0m\\e[1m"
	else
		echo -e "\\e[31m\$1\\e[0m\\e[1m"
	fi
}


shopt -s histappend

make_prompt() {
	history -a
	history -c
	history -r
#	PS1='\\[\\e[1m\\][\$(get_exit \$?) \$(get_time) \\! \\# \\u@\\h \\w]\\n\$ \\[\\e[0m\\]'
	if [[ \$VIRTUAL_ENV ]];
	then
		VENV="(\${VIRTUAL_ENV}) "
	else
		VENV=""
	fi
	if [[ -f ~/.bash_privacy ]]
	then
		PS1='\\[\\e[1m\\][\$(get_exit \$?) 19840413T133742+0000 \\! \\# user@localhost \\w ]\\n'\${VENV}'\$ \\[\\e[0m\\]'
	else
		PS1='\\[\\e[1m\\][\$(get_exit \$?) \$(get_time) \\! \\# \\u@\\h \\w ]\\n'\${VENV}'\$ \\[\\e[0m\\]'
	fi
	# set environment variable for global pwd
	echo "\$(pwd)" > ~/.globalpwd
}

cd "\$(cat ~/.globalpwd)"

PROMPT_COMMAND=make_prompt

# EOF awesome prompt

# term_title()

function term_title() {
	echo -ne "\\033]0;\${1}\\007"
}

# EOF term_title()


# cheat.sh

howto() {
	lang="\${1}"; shift
	echo curl "https://cheat.sh/"\${lang}"/\$*"
	curl "https://cheat.sh/"\${lang}"/\$*"
}

# EOF cheat.sh


PASTECONFIGURATIONFILE
cat > ~/screencast/README.md << PASTECONFIGURATIONFILE
# Screenkey

\`\`\`
./screenkey -p fixed -g 724x20+300+748 --persist
\`\`\`



PASTECONFIGURATIONFILE
cat > ~/screencast/screencast.sh << PASTECONFIGURATIONFILE
#!/bin/bash
monitor="primary"

OPTIND=1 
while getopts "h?d:" opt; do
	case "\$opt" in
	h|\\?)
		echo "usage: \${0} [-d XRANDR MONITOR NAME] [recording name]"
		exit 0;
	;;
	d)
		monitor="\$OPTARG"
	;;
	esac
done

shift \$((OPTIND-1))
[ "\${1:-}" = "--" ] && shift

if [ "\$1" ]; then
	output="\$1"
else
	output="\$(date +%Y%m%dT%H%M%S%z)"
fi


crop=\$(xrandr | grep "\${connected}" | grep "\${monitor}")
if [ -z "\${crop}" ]; then
	echo "ERROR: Could not get display crop."
	exit 1
fi

size=\$(echo "\${crop}" | head -n 1 | grep -o "[0-9]\\+x[0-9]\\++[0-9]\\++[0-9]\\+")
width=\$(echo "\${size}" | sed 's/\\([0-9]\\+\\)x\\([0-9]\\+\\)+\\([0-9]\\+\\)+\\([0-9]\\+\\)/\\1/g')
heigth=\$(echo "\${size}" | sed 's/\\([0-9]\\+\\)x\\([0-9]\\+\\)+\\([0-9]\\+\\)+\\([0-9]\\+\\)/\\2/g')
xoffset=\$(echo "\${size}" | sed 's/\\([0-9]\\+\\)x\\([0-9]\\+\\)+\\([0-9]\\+\\)+\\([0-9]\\+\\)/\\3/g')
yoffset=\$(echo "\${size}" | sed 's/\\([0-9]\\+\\)x\\([0-9]\\+\\)+\\([0-9]\\+\\)+\\([0-9]\\+\\)/\\4/g')

~/github/screenkey/screenkey -p fixed --persist -g \$(expr \${width} - 300)x20+\$(expr \${xoffset} + 300)+\$(expr \${yoffset} + \${heigth} - 20) &
SCREENKEY_PID=\$!

echo "Recording will start in 1 second ..."

sleep 1

ffmpeg -y \\
       -f x11grab -s \${width}x\${heigth} -i \${DISPLAY}+\${xoffset},\${yoffset} \\
       -f pulse -thread_queue_size 32 -i default -sample_rate 44100 -channels 1 \\
       -codec:v h264 -preset ultrafast -tune stillimage -crf 32 -r 10 \\
       -codec:a mp3 -qscale:a 0 -ac 1 -ar 44100 \\
       \${output}.mp4

# FIXME libvorbis causes wrong visual audio sync in kdenlive :(
#	-codec:a libvorbis -qscale:a 0 -ac 1 -ar 44100 \\

#ffmpeg -y \\
#       -f x11grab -s \${width}x\${heigth} -i \${DISPLAY} \\
#       -codec:v h264 -preset ultrafast -tune stillimage -crf 32 -r 10 \\
#       "\${output}.mp4"

kill \${SCREENKEY_PID}


PASTECONFIGURATIONFILE
cat > ~/screencast/convert_for_web.sh << PASTECONFIGURATIONFILE
#!/bin/bash

if [[ \$# -lt 1 ]]; then
	echo "Usage: \${0} <screencast.mp4> [start time] [end time]"
	exit 1
fi

output=\$(echo \${1} | sed 's/\\.mp4\$/_web.mp4/g')

if ! echo \${output} | grep -q "_web.mp4\$"; then
	echo "ERROR: filename does not end with .mp4"
	exit 1
fi

ss=""
to=""

if [[ \$# -ge 2 ]]; then
	ss="-ss \${2}"
fi
if [[ \$# -ge 3 ]]; then
	to="-to \${3}"
fi

ffmpeg -y -i "\${1}" \\
	-codec:v h264 -preset veryslow -profile:v baseline -level 3.0 -tune stillimage \\
	-movflags +faststart -pix_fmt yuv420p -crf 40 -r 10 \\
	-codec:a libfdk_aac -ac 1 -ar 22050 -vbr 0 \\
	\${ss} \${to} \${output}


PASTECONFIGURATIONFILE
cat > ~/.Xresources << PASTECONFIGURATIONFILE
! Fonts {{{
Xft.antialias: true
Xft.hinting:   true
Xft.rgba:      rgb
Xft.hintstyle: hintfull
Xft.dpi:       72
! }}}
PASTECONFIGURATIONFILE
cat > ~/.Xdefaults << PASTECONFIGURATIONFILE
! URxvt*termName:                       string
! URxvt*geometry:                       geometry
! URxvt*chdir:                          string
! URxvt*reverseVideo:                   boolean
! URxvt*loginShell:                     boolean
! URxvt*multiClickTime:                 number
! URxvt*jumpScroll:                     boolean
! URxvt*skipScroll:                     boolean
! URxvt*pastableTabs:                   boolean
! URxvt*scrollstyle:                    mode
! URxvt*scrollBar:                      boolean
! URxvt*scrollBar_right:                boolean
! URxvt*scrollBar_floating:             boolean
! URxvt*scrollBar_align:                mode
! URxvt*thickness:                      number
! URxvt*scrollTtyOutput:                boolean
! URxvt*scrollTtyKeypress:              boolean
! URxvt*scrollWithBuffer:               boolean
! URxvt*inheritPixmap:                  boolean
! URxvt*transparent:                    boolean
! URxvt*tintColor:                      color
! URxvt*shading:                        number
! URxvt*blurRadius:                     HxV
! URxvt*fading:                         number
! URxvt*fadeColor:                      color
! URxvt*utmpInhibit:                    boolean
! URxvt*urgentOnBell:                   boolean
! URxvt*visualBell:                     boolean
! URxvt*mapAlert:                       boolean
! URxvt*meta8:                          boolean
! URxvt*mouseWheelScrollPage:           boolean
! URxvt*tripleclickwords:               boolean
! URxvt*insecure:                       boolean
! URxvt*cursorUnderline:                boolean
! URxvt*cursorBlink:                    boolean
! URxvt*pointerBlank:                   boolean
URxvt*background:                     #000000
URxvt*foreground:                     #ffffff

urxvt*foreground: white
urxvt*background: black

*color0:  #2E3436
*color1:  #a40000
*color2:  #4E9A06
*color3:  #C4A000
*color4:  #3465A4
*color5:  #75507B
*color6:  #ce5c00
*color7:  #babdb9
*color8:  #555753
*color9:  #EF2929
*color10: #8AE234
*color11: #FCE94F
*color12: #729FCF
*color13: #AD7FA8
*color14: #fcaf3e
*color15: #EEEEEC


! URxvt*color0:                         color
! URxvt*color1:                         color
! URxvt*color2:                         color
! URxvt*color3:                         color
! URxvt*color4:                         color
! URxvt*color5:                         color
! URxvt*color6:                         color
! URxvt*color7:                         color
! URxvt*color8:                         color
! URxvt*color9:                         color
! URxvt*color10:                        color
! URxvt*color11:                        color
! URxvt*color12:                        color
! URxvt*color13:                        color
! URxvt*color14:                        color
! URxvt*color15:                        color
! URxvt*colorBD:                        color
! URxvt*colorIT:                        color
! URxvt*colorUL:                        color
! URxvt*colorRV:                        color
! URxvt*underlineColor:                 color
! URxvt*scrollColor:                    color
! URxvt*troughColor:                    color
! URxvt*highlightColor:                 color
! URxvt*highlightTextColor:             color
! URxvt*cursorColor:                    color
! URxvt*cursorColor2:                   color
! URxvt*pointerColor:                   color
! URxvt*pointerColor2:                  color
! URxvt*borderColor:                    color
! URxvt*iconFile:                       file
!URxvt*font:                          -*-*-*-*-*-*-10-*-*-*-*-*-*-*
URxvt*font:  xft:DejaVu Sans Mono:size=9
! URxvt*font:                           fontname
! URxvt*boldFont:                       fontname
! URxvt*italicFont:                     fontname
! URxvt*boldItalicFont:                 fontname
! URxvt*intensityStyles:                boolean
! URxvt*inputMethod:                    name
! URxvt*preeditType:                    style
! URxvt*imLocale:                       string
! URxvt*imFont:                         fontname
! URxvt*title:                          string
! URxvt*iconName:                       string
URxvt*saveLines:                      8388608
! URxvt*buffered:                       boolean
! URxvt*depth:                          number
! URxvt*visual:                         number
! URxvt*transient-for:                  windowid
! URxvt*override-redirect:              boolean
! URxvt*hold:                           boolean
! URxvt*externalBorder:                 number
! URxvt*internalBorder:                 number
! URxvt*borderLess:                     boolean
! URxvt*lineSpace:                      number
! URxvt*letterSpace:                    number
! URxvt*skipBuiltinGlyphs:              boolean
! URxvt*pointerBlankDelay:              number
! URxvt*backspacekey:                   string
! URxvt*deletekey:                      string
URxvt*print-pipe:                     cat > "\$(cat ~/.globalpwd)/urxvt_\$(date +%Y%m%dT%H%M%S%z).txt"
! URxvt*modifier:                       modifier
! URxvt*cutchars:                       string
! URxvt*answerbackString:               string
! URxvt*secondaryScreen:                boolean
! URxvt*secondaryScroll:                boolean
! URxvt*perl-lib:                       string
! URxvt*perl-eval:                      perl-eval
! URxvt*perl-ext-common:                string
! URxvt*perl-ext:                       string
! URxvt*xrm:                            string
! URxvt*keysym.sym:                     keysym
URxvt.keysym.Shift-Up: command:\\033]720;1\\007
URxvt.keysym.Shift-Down: command:\\033]721;1\\007
! URxvt*background.border:              boolean
! URxvt*background.expr:                string
! URxvt*background.interval:            seconds
! URxvt*bell-command:                   string
! URxvt*kuake.hotkey:                   string
! URxvt*matcher.button:                 string
! URxvt*matcher.launcher:               string
! URxvt*matcher.launcher.*:             string
! URxvt*matcher.pattern.*:              string
! URxvt*matcher.rend.*:                 string
! URxvt*remote-clipboard.fetch:         string
! URxvt*remote-clipboard.store:         string
! URxvt*searchable-scrollback:          string
! URxvt*selection-autotransform.*:      string
! URxvt*selection-pastebin.cmd:         string
! URxvt*selection-pastebin.url:         string
! URxvt*selection.pattern-0:            string
! URxvt*tab-bg:                         colour
! URxvt*tab-fg:                         colour
! URxvt*tabbar-bg:                      colour
! URxvt*tabbar-fg:                      colour
! URxvt*url-launcher:                   strinig
PASTECONFIGURATIONFILE
cat > ~/.config/gromit-mpx.cfg << PASTECONFIGURATIONFILE
"red Pen" = PEN (size=3 color="red");
"black Pen" = "red Pen" (color="black");
"red Arrow" = "red Pen" (arrowsize=2);

"big red Pen" = PEN (size=10 color="red");
"big black Pen" = "big red Pen" (color="black");
"black Arrow" = "red Arrow" (color="black");

"green Marker" = RECOLOR (color="green" size=20);
"big green Marker" = RECOLOR (color="green" size=75);

"small Eraser" = ERASER (size=20);
"big Eraser" = ERASER (size=75);
 
"default" = "red Pen";
"default"[CONTROL] = "black Pen";
"default"[3] = "big red Pen";
"default"[3+CONTROL] = "big black Pen";

"default"[2] = "red Arrow";
"default"[2+CONTROL] = "black Arrow";

"default"[SHIFT] = "small Eraser";
"default"[3+SHIFT] = "big Eraser";

"default"[SHIFT+CONTROL] = "green Marker";
"default"[3+SHIFT+CONTROL] = "big green Marker";

PASTECONFIGURATIONFILE
cat > ~/.vimrc << PASTECONFIGURATIONFILE
set history=700

set autoread

set tabstop=8
set wrap

set nolbr
set textwidth=80

set clipboard=unnamedplus

set ignorecase

set nobackup
set nowb
"set noswapfile

"noremap <Up> <Nop>
"noremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>

set hlsearch

set lazyredraw

" no sound on errors
set noerrorbells
set novisualbell
set t_vb=
"set tm=500

syntax enable
setlocal spell spelllang=en_us,de_de

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

set background=dark
colorscheme ron
set textwidth=0
set formatoptions-=
set colorcolumn=81
hi ColorColumn ctermbg=8 
hi SpellBad ctermbg=1
hi SpellLocal ctermbg=17
"--------------------------------------------------------------------------------------------------------------

"ctags
set tags=./tags;


PASTECONFIGURATIONFILE
cat > ~/.local/share/applications/mimeapps.list << PASTECONFIGURATIONFILE
[Default Applications]
application/pdf=zathura.desktop
application/http=firefox.desktop
text/x-arduino=arduino-arduinoide.desktop
images/png=eog.desktop
images/jpg=eog.desktop
images/jpeg=eog.desktop
x-scheme-handler/msteams=teams.desktop

PASTECONFIGURATIONFILE
cat > /etc/X11/xorg.conf.d/00-keyboard.conf << PASTECONFIGURATIONFILE
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,de"
	Option "XkbOptions" "grp:caps_switch"
EndSection
PASTECONFIGURATIONFILE
cat > /etc/X11/xorg.conf.d/10-evdev.conf << PASTECONFIGURATIONFILE
Section "InputClass"
	Identifier "touchpad"
	MatchIsPointer "on"
	Option "Emulate3Buttons" "on"
EndSection
PASTECONFIGURATIONFILE
cat > /etc/udev/rules.d/70-u2f.rules << PASTECONFIGURATIONFILE
# Copyright (C) 2013-2015 Yubico AB
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; either version 2.1, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser
# General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

# this udev file should be used with udev 188 and newer
ACTION!="add|change", GOTO="u2f_end"

# Yubico YubiKey
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0200|0402|0403|0406|0407|0410", TAG+="uaccess"

# Happlink (formerly Plug-Up) Security KEY
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="f1d0", TAG+="uaccess"

# Neowave Keydo and Keydo AES
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1e0d", ATTRS{idProduct}=="f1d0|f1ae", TAG+="uaccess"

# HyperSecu HyperFIDO
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="096e|2ccf", ATTRS{idProduct}=="0880", TAG+="uaccess"

# Feitian ePass FIDO, BioPass FIDO2
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="096e", ATTRS{idProduct}=="0850|0852|0853|0854|0856|0858|085a|085b|085d", TAG+="uaccess"

# JaCarta U2F
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="24dc", ATTRS{idProduct}=="0101", TAG+="uaccess"

# U2F Zero
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="8acf", TAG+="uaccess"

# VASCO SeccureClick
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1a44", ATTRS{idProduct}=="00bb", TAG+="uaccess"

# Bluink Key
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2abe", ATTRS{idProduct}=="1002", TAG+="uaccess"

# Thetis Key
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1ea8", ATTRS{idProduct}=="f025", TAG+="uaccess"

# Nitrokey FIDO U2F
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="4287", TAG+="uaccess"

# Google Titan U2F
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="5026", TAG+="uaccess"

# Tomu board + chopstx U2F
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="cdab", TAG+="uaccess"

LABEL="u2f_end"
PASTECONFIGURATIONFILE
# COPY CONFIGURATION FILES

