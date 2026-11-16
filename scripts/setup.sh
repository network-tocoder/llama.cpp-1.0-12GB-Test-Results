#!/bin/bash
# Build llama.cpp v1.0.0 with CUDA and download the model
apt update && apt install -y git cmake build-essential libcurl4-openssl-dev python3-pip tmux
git clone --depth 1 --branch v1.0.0 https://github.com/ggml-org/llama.cpp ~/llama.cpp
cd ~/llama.cpp
# CUDA arch: 89 = RTX 40xx, 86 = RTX 30xx, 120 = RTX 50xx
cmake -B build -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES=89
cmake --build build -j $(nproc) --target llama-server llama-bench
pip install -U "huggingface_hub[cli]"
hf download ukisai/Swift-1.5-Qwen3.8-Flash-Next-GSQ-RCO-GGUF --include "*IQ3_XXS*" --local-dir /workspace/models
# 16K-token prompt for the reading test
python3 -c "
import json; t=open('/root/llama.cpp/README.md').read()*6
json.dump({'prompt':t[:60000]+'\n\nSummarize the text above in 5 bullet points.','n_predict':200,'cache_prompt':False},open('/workspace/long.json','w'))"
mkdir -p /workspace/logs
