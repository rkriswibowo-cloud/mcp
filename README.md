# MCP Integration Architecture Evaluation

**Mulai di sini:** [Panduan reviewer dan peta bukti](REVIEWER_GUIDE.md).

Paket ini mengarsipkan hasil eksperimen rekonstruksi V4 dan validasi modularitas dari DataMCP. Sepuluh file Python dalam manifest asli tidak tersedia. Patch parsial tidak menggantikan source lengkap, sehingga paket ini belum dapat menjalankan ulang eksperimen.

| Lokasi | Isi |
| --- | --- |
| `source_code/` | Peta penempatan source asli untuk tiga arsitektur |
| `datasets/raw/` | Rekaman per pengulangan, bukan log per panggilan |
| `datasets/processed/` | Ringkasan waktu dan jumlah panggilan sukses |
| `datasets/synthetic/` | Ekspansi sintetis per panggilan dari agregat V4; bukan log asli |
| `experiments/functional_tests/` | Pemeriksaan konsistensi hasil yang diarsipkan |
| `experiments/runtime_tests/` | Metadata desain pengukuran waktu |
| `experiments/contract_mutation/` | CSV perubahan kontrak, laporan, dan patch |
| `metrics/` | Hasil struktural dan definisi metrik |
| `figures/` | Figur V4 dan rekonstruksi dalam PNG dan SVG |
| `environment/` | Informasi lingkungan dan manifest asli |

Dari root paket, jalankan `powershell -File ./experiments/functional_tests/check_archived_results.ps1` untuk memeriksa checksum dan mencocokkan jumlah panggilan tercatat dengan ringkasannya. Ini tidak mengulang panggilan eksperimen. `SHA256SUMS.txt` mencakup semua file paket kecuali dirinya sendiri; manifest asli mencatat hash source yang belum tersedia.

Lima klien adalah ID simulasi dan sepuluh alat merupakan mock lokal. Direct adapter dan gateway berjalan dalam proses yang sama; MCP berjalan dalam proses terpisah lewat stdio. Karena transport berbeda, hasil waktu bukan perbandingan performa yang terkontrol. Gateway tidak diikutkan dalam pengukuran mutasi kontrak. Lihat `manuscript_supplement_v4.md` untuk rincian.
