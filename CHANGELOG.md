# Changelog

## v0.2.0

- **Fix default LR** from 2e-5 to 2e-6 in `run_lora_train.sh` — upstream default causes noise and EOS failures
- **Add `resample_to_24k.sh`** — resamples audio dir to 24kHz before codec prep (prevents silent training failure)
- **Expand README** with known pitfalls table (11 bugs/edge cases from IMDA NSC runs), upstream PR tracker, recommended configuration table, data preparation section, and blog cross-links
- **Add upstream PR tracker** — shows status of PRs #178, #188, #233, #259

## v0.1.1

- Patch release

## v0.1.0

- Initial companion repo for Qwen3-TTS LoRA fine-tuning
- Patch includes LoRA training/inference/eval helpers
