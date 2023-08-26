#!/usr/bin/env bash

window=" Capture window"
screen="󰹑  Capture screen"
screen_no_cursor="󰹑  Capture screen (no cursor)"
area="󰒉  Capture area"
in_three="  Capture in 3 seconds"
in_ten="  Capture in 10 seconds"
in_three_no_cursor="  Capture in 3 seconds (no cursor)"
in_ten_no_cursor="  Capture in 10 seconds (no cursor)"

dir="$(xdg-user-dir PICTURES)/screenshots"

time=`date +%Y-%m-%d-%I-%M-%S`
filename="screenshot_${time}.png"
filepath="$dir/$filename"

normal_icon="$XDG_CONFIG_HOME/rofi/assets/image.svg"
timer_icon="$XDG_CONFIG_HOME/rofi/assets/timer.svg"

notify() {
  msg="Saved as: $filename"
  icon=$normal_icon
  extra_options=""

  if [[ $1 = "clipboard" ]]; then
    msg="Saved to clipboard."
  elif [[ $1 = "timer" ]]; then
    msg="Taking the shot in: $2"
    icon=$timer_icon
    extra_options="-r 999 -t 1000"
  else
    if [[ ! -e $filepath ]]; then
      msg="There was an error while saving the file."
    fi
  fi

  notify-send -u low -i "$icon" "Screenshot" "$msg" $extra_options
}

capture_active_win() {
  maim -u -f png -i $(xdotool getactivewindow) "$filepath"
  notify
}

capture_screen() {
  sleep 0.5 && maim -f png "$filepath" $1
  notify
}

capture_area() {
  maim -s -u -f png | xclip -selection clipboard -t image/png
  notify "clipboard"
}

capture_timed() {
	for sec in `seq $1 -1 1`; do
	  notify "timer" $sec
		sleep 1
	done

	capture_screen $2
}


if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

options="$screen\n$area\n$window\n$in_three\n$in_ten\n$screen_no_cursor\n$in_three_no_cursor\n$in_ten_no_cursor"
chosen="$(echo -e "$options" | rofi -theme $XDG_CONFIG_HOME/rofi/launchers/1.rasi -dmenu -p 'Take a shot' -selected-row 0)"

case $chosen in
  $screen)
    capture_screen
    ;;
  $screen_no_cursor)
    capture_screen "-u"
    ;;
  $area)
    capture_area
    ;;
  $window)
    capture_active_win
    ;;
  $in_three)
    capture_timed 3
    ;;
  $in_ten)
    capture_timed 10
    ;;
  $in_three_no_cursor)
    capture_timed 3 "-u"
    ;;
  $in_ten_no_cursor)
    capture_timed 10 "-u"
    ;;
esac
