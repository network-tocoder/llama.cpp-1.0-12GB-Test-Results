`Swift-Qwen3.8-Flash-Next-GSQ-RCO-IQ3_XXS-00001-of-00002.gguf`: 40925 MiB of experts, CUDA0 11681 MiB free, cache up to 4872 MiB

| cache MiB | share | t/s | hits |
|---:|---:|---:|---:|
| 4032 | 0 | 17.3 | 72% |
| 4032 | 0.5 | 18.5 | 70% |
| 4032 | 0.95 | 21.7 | 63% |
| 4864 | 0 | 21.4 | 79% |
| 4864 | 0.5 | 21.0 | 74% |
| 4864 | 0.95 | 26.2 | 68% |

machine: uploads 4.4 GiB/s, CPU 8.5 GiB/s, CPU part 0.00 ms, overlap 50.5 ms/GiB, rest 7.71 ms per token, fit within 5.0%

predicted t/s, warm cache:
| cache MiB | 0 | 0.5 | 0.8 | 0.9 | 0.95 | 0.98 |
|---:|---:|---:|---:|---:|---:|---:|
| 1984 | 11.6 | 12.6 | 15.8 | **16.9** | 17.4 | 17.2 |
| 4032 | 18.6 | 19.7 | 23.3 | **24.5** | 24.6 | 23.9 |
| 4864 | 21.6 | 22.7 | **26.7** | 27.8 | 27.7 | 26.6 |

recommended: `--moe-cache-mib 4864 --moe-cache-cpu-share 0.8` (26.7 t/s, 21.6 with share 0)
