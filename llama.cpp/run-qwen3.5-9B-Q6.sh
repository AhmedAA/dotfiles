#!/bin/bash

# Execute native backend server with Qwen 3.5 9B (UD-Q6_K_XL Quant)
./llama.cpp/build/bin/llama-server \
  --model llms/Qwen3.5-9B-UD-Q6_K_XL.gguf \
  --alias qwen9b \
  --host 0.0.0.0 \
  --port 11434 \
  --n-gpu-layers 99 \
  --threads 4 \
  --ctx-size 32768 \
  --cache-type-k q8_0 \
  --cache-type-v q8_0 \
  --flash-attn on \
  --parallel 1 \
  --min-p 0.05 \
  --dry-multiplier 0.8 \
  --dry-base 2.0 \
  --jinja
