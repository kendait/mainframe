#!/usr/local/bin/bash

targetAction="$1"
targetApp="$2"

execute_action() {

  minimize_all_windows() {
    targetApp="$1"
    osascript <<-EOF
      tell application "$targetApp"
        activate
        set theWindows to every window
        repeat with i from 1 to count of theWindows
          set thisWindow to item i of theWindows
          set index of thisWindow to 1
          tell application "System Events" to keystroke "m" using {command down}
          delay .25
        end repeat
      end tell
EOF
  }

  restore_all_windows() {
    targetApp="$1"
    osascript <<-EOF
    tell application "$targetApp"
      set theWindows to every window
      repeat with i from 1 to count of theWindows
        set thisWindow to item i of theWindows
        set visible of thisWindow to true
      end repeat
    end tell
EOF
  }

  hide_all_windows() {
    targetApp="$1"
    osascript <<-EOF
    tell application "$targetApp"
      set theWindows to every window
      repeat with i from 1 to count of theWindows
        set thisWindow to item i of theWindows
        set visible of thisWindow to false
        delay .1
      end repeat
    end tell
EOF
  }

  close_all_windows() {
    targetApp="$1"
    osascript <<-EOF
    tell application "$targetApp"
      activate
      set theWindows to every window
      repeat with i from 1 to count of theWindows
        set thisWindow to item i of theWindows
        set index of thisWindow to 1
        delay .1
        tell application "System Events" to keystroke "w" using {command down}
        delay .25
      end repeat
    end tell
EOF
  }

  case $targetAction in
    minAll)
      minimize_all_windows "$targetApp"
      ;;
    restoreAll)
      restore_all_windows "$targetApp"
      ;;
    hideAll)
      hide_all_windows "$targetApp"
      ;;
    closeAll)
      close_all_windows "$targetApp"
      ;;
  esac
}

execute_action
