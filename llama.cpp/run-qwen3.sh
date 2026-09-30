#!/bin/bash

# Execute native backend server with Qwen3 8B (Non-Thinking Mode)
./llama.cpp/build/bin/llama-server \
  --model llms/Qwen3-8B-UD-Q4_K_XL.gguf \
  --alias qwen3 \
  --host 0.0.0.0 \
  --port 11434 \
  --n-gpu-layers 99 \
  --threads 4 \
  --ctx-size 16384 \
  --parallel 1 \
  --temp 0.7 \
  --top-p 0.80 \
  --top-k 20 \
  --presence-penalty 1.5 \
  --jinja
