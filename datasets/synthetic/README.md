# Dataset sintetis per panggilan

`call_slots_v4.csv` adalah ekspansi deterministik dari `datasets/raw/raw_trials_v4.csv` dan desain di `experiments/runtime_tests/protocol_metadata_v4.json`. File ini bukan log asli dan bukan hasil pengukuran baru.

- `architecture` dan `trial` adalah kunci untuk menghubungkan baris dengan tabel pengulangan.
- `client_slot` dan `tool_slot` adalah nomor buatan. Nomor ini bukan identitas klien, nama alat, atau urutan eksekusi.
- `status=success` diturunkan dari fakta bahwa semua 50 panggilan dalam setiap pengulangan tercatat sukses.
- `data_origin=synthetic_from_trial_aggregate` menandai asal setiap baris.

Waktu setup dan durasi total tetap di CSV asli. Latensi per panggilan, payload, dan timestamp tidak diketahui. Jangan gunakan 750 baris ini sebagai 750 pengamatan independen atau untuk menghitung distribusi latensi.

Regenerasi dari root paket: `powershell -File ./experiments/functional_tests/build_synthetic_calls.ps1`.
