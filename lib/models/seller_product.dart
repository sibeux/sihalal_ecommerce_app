class SellerProduct {
  final String uidProduct, kategori, uidUser, nama, deskripsi;
  final String foto1, foto2, foto3;
  final String harga, stok, berat, countReview;
  final bool isVisible;

  SellerProduct({
    required this.uidProduct,
    required this.kategori,
    required this.uidUser,
    required this.foto1,
    required this.foto2,
    required this.foto3,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.stok,
    required this.berat,
    required this.isVisible,
    required this.countReview,
  });
}
