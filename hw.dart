//inisiasi repo

//enum digunain buat nilai yang pilihannya sudah pasti dan terbatas
//karena pada business rule nya ada ketentuan kalo ada layanan express maka pasti ada layanan yang normal
enum Layanan {normal, express} 

//class transaksi buat nyimpen data transaksi yang nantinya dilakukan
class Transaksi {
  double berat; 
  Layanan layanan;
  Transaksi({required this.berat, required this.layanan});
}

//karena ketentuan tugasnya disuruh buat 4 fungsi
//fungsi 1, buat ngecek berat, kalo beratnya kurang dari 2 maka dibalikin jadi 2
//karena di business rule nya ada ketentuan kalo berat minimal 2 kg dan kalo dibawah 2 kg tetep diitung 2kg
double cekBerat(double berat) {
  if (berat < 2) {
    return 2;
  }
  return berat;
}

//fungsi 2, buuat nentuin harga dasar. karena di business rule nya harga /kg nya 7000, jadi 7000
double hitungHargaDasar(double berat) {
  return berat * 7000;
}

//fungsi 3, buat ngitung harga kalo milih layanan express
//kalo gapake layanan express return 0 dan ga kena biaya tambahan 50%
double hitungExpress(double hargaDasar, Layanan layanan) {
  if (layanan == Layanan.express) {
    return hargaDasar * 0.5;
  }
  return 0;
}

//fungsi 4, buat ngitung total harga, dan ngecek kalo beratnya dibawah 0 atau 0 kg maka returnny error
String prosesTransaksi(Transaksi transaksiLaundry) {
  // ngecek beratnya valid apa ngga
  if (transaksiLaundry.berat <= 0) {
    return "Error : berat gaboleh 0 /dibawah 0";
  }

  // manggil fungsi fungsi
  double hitungBerat = cekBerat(transaksiLaundry.berat);
  double dasar = hitungHargaDasar(hitungBerat);
  double express = hitungExpress(dasar, transaksiLaundry.layanan);

  double total = dasar + express;

  return "Berat : ${transaksiLaundry.berat} kg (Dihitung : $hitungBerat kg) | Layanan : ${transaksiLaundry.layanan} | total : Rp. $total";
}

void main() {
  //karena ketentuan tugasnya disuruh pake list jadi saya pake list dan bikin 5 skenario sesuai ketentuan tugas
  List<Transaksi> listLaundry = [
    Transaksi(berat: 1.5, layanan: Layanan.normal), // Skenario 1: di bawah 2kg reguler (Expected: 14000)
    Transaksi(berat: 3.0, layanan: Layanan.normal), // Skenario 2: di atas 2kg reguler (Expected: 21000)
    Transaksi(berat: 1.0, layanan: Layanan.express), // Skenario 3: di bawah 2kg express (Expected: 21000)
    Transaksi(berat: 4.0, layanan: Layanan.express), // Skenario 4: di atas 2kg express (Expected: 42000)
    Transaksi(berat: -2.0, layanan: Layanan.normal), // Skenario 5: uji gagal / input minus
  ];

  // Perulangan buat nyetak hasil
  for (var data in listLaundry) {
    print(prosesTransaksi(data));
  }
}

