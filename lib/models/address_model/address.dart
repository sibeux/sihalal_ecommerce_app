class Address {
  final String idAddress, idUser;
  final String name,
      phone,
      label,
      province,
      idProvince,
      city,
      idCity,
      postalCode;
  final String detailAddress, streetAddress, pinPoint;
  final bool isPrimary, isStore;

  Address({
    required this.idAddress,
    required this.idUser,
    required this.name,
    required this.phone,
    required this.label,
    required this.province,
    required this.idProvince,
    required this.city,
    required this.idCity,
    required this.postalCode,
    required this.detailAddress,
    required this.streetAddress,
    required this.pinPoint,
    required this.isPrimary,
    required this.isStore,
  });
}
