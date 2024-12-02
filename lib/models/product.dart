class Product {
  final String uidProduct, uidShhalal, uidUser, nama, deskripsi, kota;
  final String foto1, foto2, foto3;
  final String harga, rating, stok, berat, jumlahUlasan, jumlahRating;
  final String kategori, merek, nomorHalal;
  bool isFavorite;

  Product({
    required this.uidProduct,
    required this.uidShhalal,
    required this.uidUser,
    required this.foto1,
    required this.foto2,
    required this.foto3,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    required this.stok,
    required this.berat,
    required this.jumlahUlasan,
    required this.jumlahRating,
    required this.kota,
    required this.kategori,
    required this.merek,
    required this.nomorHalal,
    required this.isFavorite,
  });
}
