#!/bin/bash

# Show current GPU status
nvidia-smi

# Clean SGLang processes
kill -9 $(ps aux | grep 'sglang::' | grep -v 'grep' | awk '{print $2}') 2>/dev/null
kill -9 $(ps aux | grep 'sglang.launch_server' | grep -v 'grep' | awk '{print $2}') 2>/dev/null
kill -9 $(ps aux | grep 'sglang.bench' | grep -v 'grep' | awk '{print $2}') 2>/dev/null

# Clean all GPU processes if any argument is provided
if [ $# -gt 0 ]; then
    kill -9 $(nvidia-smi | sed -n '/Processes:/,$p' | grep "   [0-9]" | awk '{print $5}') 2>/dev/null
    lsof /dev/nvidia* | awk '{print $2}' | xargs kill -9 2>/dev/null
fi


# Show GPU status after clean up
nvidia-smi
