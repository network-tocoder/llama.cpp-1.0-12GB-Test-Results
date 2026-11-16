#!/bin/bash
# Usage: ./run.sh <label> [extra llama-server args]
# 3 x 800-token answers (different topics) + one 16K-token prompt. Results -> results.txt
M=$(find /workspace/models -name "*IQ3_XXS-00001*.gguf" | head -1)
L=$1; shift
cd ~/llama.cpp
./build/bin/llama-server -m $M -c 65536 -ctk q8_0 -ctv q8_0 -fa on -t 20 -cmoe --port 8081 "$@" > /workspace/logs/$L.log 2>&1 &
P=$!
until curl -s localhost:8081/health | grep -q ok; do kill -0 $P 2>/dev/null || { echo "$L: server died, see /workspace/logs/$L.log"; exit 1; }; sleep 5; done
T=("how a CPU cache works" "how a GPU renders a frame" "how TCP handles packet loss")
for i in 0 1 2; do
 curl -s localhost:8081/completion -d "{\"prompt\":\"Explain in detail ${T[$i]}, with examples.\",\"n_predict\":800,\"ignore_eos\":true,\"cache_prompt\":false}" \
 | python3 -c "import sys,json;t=json.load(sys.stdin)['timings'];print('$L run$i  write %.1f tok/s (%d tok)'%(t['predicted_per_second'],t['predicted_n']))"
done | tee -a /workspace/results.txt
curl -s localhost:8081/completion -d @/workspace/long.json | python3 -c "import sys,json;t=json.load(sys.stdin)['timings'];print('$L LONG  read %.0f tok/s (%d tok prompt)'%(t['prompt_per_second'],t['prompt_n']))" | tee -a /workspace/results.txt
kill $P; wait $P 2>/dev/null
