class SellerOrder {
  final String idPesanan, noPesanan, idUserPenerima, idProduk;
  final String jumlah, pengiriman, namaNoPenerima, alamatPenerima;
  final String subtotalHargaBarang, subtotalPengiriman, totalPembayaran;
  final String tanggalPesanan, statusPesanan;
  final String idUserToko, namaToko, namaProduk, fotoProduk;

  SellerOrder({
    required this.idPesanan,
    required this.noPesanan,
    required this.idUserPenerima,
    required this.idProduk,
    required this.jumlah,
    required this.pengiriman,
    required this.namaNoPenerima,
    required this.alamatPenerima,
    required this.subtotalHargaBarang,
    required this.subtotalPengiriman,
    required this.totalPembayaran,
    required this.tanggalPesanan,
    required this.statusPesanan,
    required this.idUserToko,
    required this.namaToko,
    required this.namaProduk,
    required this.fotoProduk,
  });
}
