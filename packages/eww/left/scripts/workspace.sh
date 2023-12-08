#!/usr/bin/env bash

active_workspace=$(hyprctl activewindow -j | jq -r '.workspace.id')
hyprctl workspaces -j | jq -r  "map({name: .name, focused: (.name == \"$active_workspace\")}) | sort_by(.name | tonumber)"
