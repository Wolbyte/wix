#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers"

rofi \
  -show drun \
  -theme "${dir}/$1.rasi"
