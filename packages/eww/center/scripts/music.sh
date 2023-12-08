#!/usr/bin/env bash
case $1 in
    "current-song")
        playerctl --follow metadata title
        ;;

    "progress")
        playerctl metadata --format "{{ position * 100 / mpris:length }}" --follow
        ;;

    "set-progress")
        offset=$(playerctl -p tidal-hifi metadata --format "{{ ($2 * mpris:length) / 100000000 }}")
        playerctl -p tidal-hifi position "$offset" +
        # fi
        ;;
esac
