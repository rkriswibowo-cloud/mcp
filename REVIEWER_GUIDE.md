# Panduan reviewer

Arsip ini mendokumentasikan evaluasi tiga arsitektur integrasi pada prototipe rekonstruksi V4: Traditional, Non-MCP gateway, dan Official MCP SDK. Bukti ini tidak memvalidasi ulang angka historis naskah dan tidak berasal dari layanan produksi.

## Urutan baca

1. Baca [ringkasan hasil V4](manuscript_supplement_v4.md) dan [desain eksperimen](experiments/runtime_tests/protocol_metadata_v4.json). Eksperimen memakai lima ID klien simulasi, sepuluh alat mock lokal, dan lima pengulangan per arsitektur.
2. Telusuri klaim ke tabel sumber melalui peta bukti di bawah. Gunakan figur sebagai visualisasi, bukan pengganti tabel sumber.
3. Baca [informasi lingkungan](environment/environment_info.md) dan [status source](source_code/README.md) sebelum menilai keterulangan.

## Peta bukti

| Pertanyaan reviewer | Bukti utama | Unit dan batas penilaian |
| --- | --- | --- |
| Apakah panggilan tercatat berhasil? | [Data per pengulangan](datasets/raw/raw_trials_v4.csv) dan [ringkasan](datasets/processed/summary_trials_v4.csv) | Lima pengulangan per arsitektur; 250 sukses tercatat per arsitektur. Bukan log per panggilan. |
| Bagaimana waktu setup dan eksekusi dibandingkan? | [Ringkasan waktu](datasets/processed/summary_trials_v4.csv), [figur setup](figures/v4/Figure_07_Setup_time.svg), [figur eksekusi](figures/v4/Figure_06_Execution_time.svg) | Waktu per pengulangan, bukan latensi per panggilan. MCP memakai stdio; arsitektur lain berjalan in-process. Selisih waktu tidak mengisolasi efek arsitektur. |
| Bagaimana NIP dan reachability diperoleh? | [Definisi metrik](metrics/metric_definitions/metric_definitions_v4.json), [figur NIP](figures/v4/Figure_01_NIP_analytic.svg), [figur reachability](figures/v4/Figure_02_Reachability_analytic.svg) | Turunan topologi, bukan pengukuran independen. NIP Traditional 50; gateway dan MCP sama-sama 15. |
| Bagaimana struktur kode dibandingkan? | [Ringkasan struktural](metrics/structural_metrics/structural_summary_v4.csv), [bukti coupling](metrics/structural_metrics/cbo_edges_v4.csv), [bukti cohesion](metrics/structural_metrics/cohm_pairs_v4.csv) | CBO adalah proksi pada tingkat modul; Cohm definisi operasional studi. Jumlah modul berbeda antararsitektur; lima pengulangan waktu bukan lima observasi struktural. |
| Berapa file berubah saat kontrak berubah? | [Hasil per skenario](experiments/contract_mutation/ripple_actual_changes.csv), [patch](experiments/contract_mutation/patches/), [protokol](metrics/metric_definitions/measurement_protocol.json) | Lima jenis perubahan. Traditional dan MCP masing-masing rata-rata satu file integrasi; file provider dicatat terpisah. Gateway tidak diukur. |

## Status data dan verifikasi

- **Artefak pengukuran yang tersedia:** CSV di `datasets/raw/` adalah arsip pada tingkat pengulangan, bukan dataset asli pada tingkat panggilan.
- **Data sintetis:** [CSV per slot panggilan](datasets/synthetic/call_slots_v4.csv) hanya ekspansi administratif dari agregat. Jangan gunakan untuk menambah ukuran sampel, menghitung latensi, atau mendukung klaim empiris baru.
- **Verifikasi arsip:** dari root paket, jalankan `powershell -File ./experiments/functional_tests/check_archived_results.ps1`. Skrip memeriksa checksum dan konsistensi jumlah panggilan; skrip tidak menjalankan prototipe atau mengulang pengukuran.
- **Keterulangan:** 10 file Python dalam [manifest historis](environment/reproducibility_manifest.json) belum tersedia. Hash paket bukan verifikasi source atau metode pengukuran. TINT tidak diukur.
- **Distribusi:** [status lisensi](LICENSE) belum dikonfirmasi; pastikan izin sebelum publikasi atau distribusi.
