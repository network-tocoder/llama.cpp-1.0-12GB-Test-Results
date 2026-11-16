#!/bin/bash
# The exact test sequence from the video (run ONE at a time, one terminal only)
~/run.sh t1_default
~/run.sh t2_cache_s0     --moe-cache-mib 5000
~/run.sh t3_s05          --moe-cache-mib 5000 --moe-cache-cpu-share 0.5
~/run.sh t3_s095         --moe-cache-mib 5000 --moe-cache-cpu-share 0.95
~/run.sh t4_none_s095    --moe-cache-mib 5000 -lm none  --moe-cache-cpu-share 0.95
~/run.sh t4_mlock_s095   --moe-cache-mib 5000 -lm mlock --moe-cache-cpu-share 0.95
~/run.sh t4_none_s0      --moe-cache-mib 5000 -lm none
~/run.sh t8_none_s0_spec --moe-cache-mib 5000 -lm none --spec-default
~/run.sh t10_none_s0_t40 --moe-cache-mib 5000 -lm none -t 40
~/run.sh t5_tuned        --moe-cache-mib 4864 --moe-cache-cpu-share 0.8
~/run.sh final_recipe    --moe-cache-mib 4864 -lm none -t 40
# tuning script (memory-mapped, then pinned)
M=$(find /workspace/models -name "*IQ3_XXS-00001*.gguf" | head -1)
cd ~/llama.cpp
python3 scripts/moe-cache-tune.py --markdown -- build/bin/llama-server -m $M -cmoe -t 20 -c 65536 -ctk q8_0 -ctv q8_0 -fa on | tee /workspace/tune.txt
python3 scripts/moe-cache-tune.py --markdown --out tune_none -- build/bin/llama-server -m $M -cmoe -t 20 -c 65536 -ctk q8_0 -ctv q8_0 -fa on -lm none | tee /workspace/tune_none.txt
