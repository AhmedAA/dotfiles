#!/bin/bash

# Execute native backend server with Qwen3.5 9B (Non-Thinking Mode)
./llama.cpp/build/bin/llama-server \
  --model llms/Qwen3.5-9B-UD-Q4_K_XL.gguf \
  --alias qwen3.5 \
  --host 0.0.0.0 \
  --port 11434 \
  --n-gpu-layers 99 \
  --threads 4 \
  --ctx-size 32768 \
  --cache-type-k q8_0 \
  --cache-type-v q8_0 \
  --flash-attn on \
  --parallel 1 \
  --temp 0.7 \
  --top-p 0.80 \
  --top-k 20 \
  --presence-penalty 1.5 \
  --jinja
