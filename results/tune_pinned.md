`Swift-Qwen3.8-Flash-Next-GSQ-RCO-IQ3_XXS-00001-of-00002.gguf`: 40925 MiB of experts, CUDA0 11681 MiB free, cache up to 4872 MiB

| cache MiB | share | t/s | hits |
|---:|---:|---:|---:|
| 4032 | 0 | 25.7 | 72% |
| 4032 | 0.5 | 28.2 | 70% |
| 4032 | 0.95 | 24.5 | 63% |
| 4864 | 0 | 29.8 | 79% |
| 4864 | 0.5 | 29.7 | 74% |
| 4864 | 0.95 | 26.0 | 68% |

machine: uploads 10.5 GiB/s, CPU 15.1 GiB/s, CPU part 4.28 ms, overlap -47.6 ms/GiB, rest 17.83 ms per token, fit within 0.0%

predicted t/s, warm cache:
| cache MiB | 0 | 0.5 | 0.8 | 0.9 | 0.95 | 0.98 |
|---:|---:|---:|---:|---:|---:|---:|
| 1984 | 19.8 | **23.4** | 22.1 | 21.4 | 20.8 | 20.2 |
| 4032 | 27.1 | **29.0** | 27.2 | 26.3 | 25.5 | 24.5 |
| 4864 | **29.6** | 30.8 | 29.0 | 28.0 | 27.1 | 26.0 |

recommended: `--moe-cache-mib 4864 --moe-cache-cpu-share 0` (29.6 t/s)
