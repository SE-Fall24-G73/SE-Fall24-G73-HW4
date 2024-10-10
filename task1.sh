#!/bin/bash
pid=$(ps aux | grep '[i]nfinite.sh' | awk '{print $2}') && [ -n "$pid" ] && kill "$pid" && echo "Killed process with PID: $pid" || echo "No infinite.sh process found."
