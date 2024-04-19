{
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  inherit (osConfig.wb) device system;

  acceptedTypes = ["desktop" "hybrid"];
in {
  config = mkIf (builtins.elem device.profile acceptedTypes && system.video.enable) {
    home.packages = [
      (pkgs.writeShellScriptBin "rofi-screenshot" ''
        screen="󰹑  Capture screen"
        screen_no_cursor="󰹑  Capture screen (no cursor)"
        area="󰒉  Capture area"
        in_three="  Capture in 3s"
        in_ten="  Capture in 10s"
        in_three_no_cursor="  Capture in 3s (no cursor)"
        in_ten_no_cursor="  Capture in 10s (no cursor)"

        dir="$(xdg-user-dir PICTURES)/screenshots"

        time=$(date +%Y-%m-%d-%I-%M-%S)
        filename="screenshot_$time.png"
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

        capture_screen() {
         if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
          if [ "$1" = "-u" ]; then
           sleep 1 && grim "$filepath"
          else
           sleep 1 && grim -c "$filepath"
          fi
         else
          sleep 1 && maim -f png "$filepath" $1
         fi

         notify
        }

        capture_area() {
         if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
          slurp | grim -g - - | wl-copy
         else
          maim -s -u -f png | xclip -selection clipboard -t image/png
         fi

         notify "clipboard"
        }

        capture_timed() {
         for sec in $(seq "$1" -1 1); do
          notify "timer" "$sec"
          sleep 1
         done

         capture_screen "$2"
        }

        if [[ ! -d "$dir" ]]; then
         mkdir -p "$dir"
        fi

        options="$screen\n$area\n$in_three\n$in_ten\n$screen_no_cursor\n$in_three_no_cursor\n$in_ten_no_cursor"
        chosen="$(echo -e "$options" | rofi -theme ~/.config/rofi/config.rasi -dmenu -p 'Take a shot' -selected-row 0)"

        case $chosen in
        "$screen")
         capture_screen
         ;;
        "$screen_no_cursor")
         capture_screen "-u"
         ;;
        "$area")
         capture_area
         ;;
        "$in_three")
         capture_timed 3
         ;;
        "$in_ten")
         capture_timed 10
         ;;
        "$in_three_no_cursor")
         capture_timed 3 "-u"
         ;;
        "$in_ten_no_cursor")
         capture_timed 10 "-u"
         ;;
        esac
      '')
    ];
  };
}
