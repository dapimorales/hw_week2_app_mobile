## Bagian A — Dokumen Analisis

### 1. Problem Statement
Sistem manajemen laundry membutuhkan perhitungan total biaya cucian otomatis yang dapat menerapkan aturan batas minimal berat cucian dan perhitungan biaya tambahan untuk pilihan layanan express.

### 2. Actor
* Pelanggan
* Kasir / Admin Laundry

### 3. Input & Output
* **Input:** `berat` (double), `layanan` (Enum)
* **Output:** Informasi rincian berat dihitung, jenis layanan, status error (jika input invalid), dan total harga (Rp)

### 4. Functional Requirement
1. Sistem dapat menerima input berat cucian dan pilihan layanan (normal / express).
2. Sistem secara otomatis menyesuaikan berat cucian menjadi minimal 2 kg jika input berat di bawah 2 kg.
3. Sistem menghitung tarif dasar laundry sebesar Rp7.000 per kg.
4. Sistem menambahkan biaya +50% dari harga dasar jika pelanggan memilih layanan express.
5. Sistem memvalidasi input berat agar tidak bernilai 0 atau negatif (kembalikan pesan error).

### 5. Business Rules
* **BR-01:** Tarif dasar laundry adalah Rp7.000 per kg.
* **BR-02:** Berat cucian di bawah 2 kg dihitung sebagai 2 kg.
* **BR-03:** Layanan express dikenakan biaya tambahan sebesar 50% (+50%) dari harga dasar.
* **BR-04:** Input berat cucian harus lebih dari 0 kg (`berat > 0`).

### 6. Decomposition
1. `cekBerat(berat)`: Mengubah berat di bawah 2 kg menjadi 2 kg.
2. `hitungHargaDasar(berat)`: Mengalikan berat efektif dengan tarif Rp7.000/kg.
3. `hitungExpress(hargaDasar, layanan)`: Menghitung biaya tambahan 50% jika layanan express dipilih.
4. `prosesTransaksi(transaksiLaundry)`: Validasi input, pemanggilan fungsi-fungsi, perhitungan total, dan penyusunan output teks.

### 7. Pattern Recognition
* **Minimum Threshold:** Menggunakan pengondisian jika `berat < 2` maka nilai yang digunakan adalah `2`.
* **Percentage Calculation:** Tambahan express dihitung dengan rumus `hargaDasar * 0.5`.
* **Accumulation:** Total akhir diperoleh dari penjumlahan `dasar + express`.

### 8. Abstraction
* **Enum:** `Layanan { normal, express }`
* **Class Model:** `Transaksi`
  * Atribut: `double berat`, `Layanan layanan`

### 9. Algorithm
1. Terima input objek `Transaksi` (`berat` dan `layanan`).
2. Cek apakah `berat <= 0`. Jika ya, kembalikan teks `"Error : berat gaboleh 0 /dibawah 0"` dan berhenti.
3. Hitung `hitungBerat` menggunakan fungsi `cekBerat(berat)`.
4. Hitung `dasar` menggunakan fungsi `hitungHargaDasar(hitungBerat)`.
5. Hitung `express` menggunakan fungsi `hitungExpress(dasar, layanan)`.
6. Hitung `total = dasar + express`.
7. Tampilkan/kembalikan rincian string transaksi.

### 10. Flowchart (Proses Utama)
```text
[ Mulai ]
    │
    ▼
[ Input: berat, layanan ]
    │
    ▼
< Apakah berat <= 0? > ─── Ya ───► [ Return: "Error : berat gaboleh 0 /dibawah 0" ]
    │ Tidak
    ▼
< Apakah berat < 2? >
    ├─── Ya ────► [ hitungBerat = 2 ]
    └─── Tidak ──► [ hitungBerat = berat ]
    │
    ▼
[ dasar = hitungBerat * 7000 ]
    │
    ▼
< Apakah layanan == express? >
    ├─── Ya ────► [ express = dasar * 0.5 ]
    └─── Tidak ──► [ express = 0 ]
    │
    ▼
[ total = dasar + express ]
    │
    ▼
[ Return Teks Rincian Transaksi ] ──► [ Selesai ]
```
### 11. Pseudocode
ENUM Layanan { normal, express }

CLASS Transaksi
    PROPERTIES: berat (DOUBLE), layanan (LAYANAN)

FUNCTION cekBerat(berat)
    IF berat < 2 THEN
        RETURN 2
    END IF
    RETURN berat
END FUNCTION

FUNCTION hitungHargaDasar(berat)
    RETURN berat * 7000
END FUNCTION

FUNCTION hitungExpress(hargaDasar, layanan)
    IF layanan == Layanan.express THEN
        RETURN hargaDasar * 0.5
    END IF
    RETURN 0
END FUNCTION

FUNCTION prosesTransaksi(transaksiLaundry)
    IF transaksiLaundry.berat <= 0 THEN
        RETURN "Error : berat gaboleh 0 /dibawah 0"
    END IF

    VAR hitungBerat = cekBerat(transaksiLaundry.berat)
    VAR dasar = hitungHargaDasar(hitungBerat)
    VAR express = hitungExpress(dasar, transaksiLaundry.layanan)
    VAR total = dasar + express

    RETURN "Berat: " + transaksiLaundry.berat + " kg | Total: Rp. " + total
END FUNCTION
