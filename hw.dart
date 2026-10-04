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

