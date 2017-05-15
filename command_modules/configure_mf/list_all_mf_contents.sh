#!/usr/local/bin/bash
# List all contents of mainframe

find $MAINFRAME_PATH | grep -v '\.git' | grep -v '\.old' | less
