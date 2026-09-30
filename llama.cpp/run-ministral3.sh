#!/bin/bash

# Execute native backend server with Ministral 3 8B (Knowledge Base Mode)
./llama.cpp/build/bin/llama-server \
  --model llms/Ministral-3-8B-Instruct-2512-UD-Q4_K_XL.gguf \
  --alias ministral \
  --host 0.0.0.0 \
  --port 11435 \
  --n-gpu-layers 99 \
  --threads 4 \
  --ctx-size 32768 \
  --cache-type-k q8_0 \
  --cache-type-v q8_0 \
  --flash-attn on \
  --parallel 1 \
  --temp 0.7 \
  --top-p 0.90 \
  --jinja
