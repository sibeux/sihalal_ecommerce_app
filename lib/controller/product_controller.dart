import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/merksh.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/models/seller_product.dart';
import 'package:image_picker/image_picker.dart';

class SearchProductController extends GetxController {
  final controller = TextEditingController();
  var isTyping = false.obs;
  var textValue = ''.obs;
  var isKeybordFocus = false.obs;
  var isSearch = false.obs;

  void onChanged(String value) {
    isTyping.value = value.isNotEmpty;
    textValue.value = value;
    isKeybordFocus.value = true;
    filterProduct(value);
    update();
  }

  void filterProduct(String value) {
    isSearch.value = !isSearch.value;
    update();
  }

  get getTextValue => textValue.value;

  get isTypingValue => isTyping.value;
}

class GetScrollLeftProductController extends GetxController {
  var recentProduct = RxList<Product?>([]);
  var isLoading = false.obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // ** tidak perlu await karena biar bisa dijalankan bersamaan
    getLeftProduct('recent');
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // ** ini untuk footer load more
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }

  Future<void> getLeftProduct(String sort) async {
    isLoading.value = true;

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=scroll_left&sort=$sort';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      final list = listData.map((produk) {
        return Product(
          uidProduct: produk['id_produk'],
          uidUser: produk['id_user'],
          uidShhalal: produk['id_shhalal'],
          nama: produk['nama_produk'],
          deskripsi: produk['deskripsi_produk'] ?? '--',
          rating: produk['rating_produk'],
          harga: produk['harga_produk'],
          foto1: regexGdriveLink(
              produk['foto_produk_1'], apiData[0]['gdrive_api']),
          foto2: produk['foto_produk_2'] == null
              ? ''
              : regexGdriveLink(
                  produk['foto_produk_2'], apiData[0]['gdrive_api']),
          foto3: produk['foto_produk_3'] == null
              ? ''
              : regexGdriveLink(
                  produk['foto_produk_3'], apiData[0]['gdrive_api']),
          stok: produk['stok_produk'],
          jumlahUlasan: produk['jumlah_ulasan'],
          jumlahRating: produk['jumlah_rating'],
          kota: produk['kota'],
        );
      }).toList();

      recentProduct.value = list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      // ini tetap dieksekusi baik berhasil atau gagal
      isLoading.value = false;
    }
  }
}

class GetSellerProductController extends GetxController {
  var isGetProductLoading = false.obs;
  var needRefresh = false.obs;

  var sellerProductList = RxList<SellerProduct>([]);
  var visibleProductList = RxList<SellerProduct>([]);
  var invisibleProductList = RxList<SellerProduct>([]);
  var outStockProductList = RxList<SellerProduct>([]);

  var productVisible = 0.obs;
  var productInvisible = 0.obs;
  var productOutStock = 0.obs;
  var currentFilterProductList = 0.obs;

  void changeFilterProductList(int index) {
    currentFilterProductList.value = index;
    update();
  }

  void getProducts({required String email}) async {
    await getUserProduct(email: email);
  }

  Future<void> getUserProduct({required String email}) async {
    isGetProductLoading.value = true;

    productInvisible.value = 0;
    productVisible.value = 0;
    productOutStock.value = 0;

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=user_product&email=$email';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      if (listData.isNotEmpty) {
        final list = listData.map((produk) {
          if (produk['is_ditampilkan'] == 'true') {
            productVisible.value++;
          } else {
            productInvisible.value++;
          }
          if (produk['stok_produk'] == '0') {
            productOutStock.value++;
          }
          return SellerProduct(
            uidProduct: produk['id_produk'],
            uidUser: produk['id_user'],
            uidShhalal: produk['id_shhalal'],
            nama: produk['nama_produk'],
            deskripsi: produk['deskripsi_produk'] ?? '--',
            harga: produk['harga_produk'],
            foto1: regexGdriveLink(
                produk['foto_produk_1'], apiData[0]['gdrive_api']),
            foto2: produk['foto_produk_2'] == null
                ? ''
                : regexGdriveLink(
                    produk['foto_produk_2'], apiData[0]['gdrive_api']),
            foto3: produk['foto_produk_3'] == null
                ? ''
                : regexGdriveLink(
                    produk['foto_produk_3'], apiData[0]['gdrive_api']),
            stok: produk['stok_produk'] ?? '0',
            berat: produk['berat_produk'] ?? '0',
            isVisible: produk['is_ditampilkan'] == 'true',
            countReview: produk['jumlah_ulasan'] ?? '0',
            kategori: produk['kategori_shhalal'],
            nomorSH: produk['nomor_shhalal'],
            merek: produk['merek_shhalal'],
          );
        }).toList();

        sellerProductList.value = list;
        visibleProductList.value =
            list.where((data) => data.isVisible).toList();
        invisibleProductList.value =
            list.where((data) => !data.isVisible).toList();
        outStockProductList.value =
            list.where((data) => data.stok == '0').toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isGetProductLoading.value = false;
      needRefresh.value = !needRefresh.value;
    }
  }
}

class SellerProductController extends GetxController {
  var countImage = 0.obs;

  var urlImage1 = ''.obs;
  var urlImage2 = ''.obs;
  var urlImage3 = ''.obs;

  var currentIdProduct = '';
  var idShhalal = '';
  var nameProduct = ''.obs;
  var descriptionProduct = ''.obs;
  var categoryProduct = ''.obs;
  var merkProduct = ''.obs;
  var noHalalProduct = ''.obs;
  var priceProduct = ''.obs;
  var stockProduct = ''.obs;
  var weightProduct = ''.obs;

  var isGetMerkshLoading = false.obs;
  var isInsertImageLoading = false.obs;
  var isNeedLoading = false.obs;
  var isImageFileTooLarge = false.obs;
  var isImageChanged = false;

  var listMerkshProduct = RxList<Merksh>([]);

  var nameProductTextController = TextEditingController();
  var descriptionProductTextController = TextEditingController();
  var priceProductTextController = TextEditingController();
  var stockProductTextController = TextEditingController();
  var weightProductTextController = TextEditingController();

  @override
  void onInit() {
    stockProduct.value = '0';
    stockProductTextController.text = stockProduct.value;
    super.onInit();
  }

  void setValueChangeProduct({required SellerProduct product}) {
    countImage.value = product.foto2.isEmpty
        ? 1
        : product.foto3.isEmpty
            ? 2
            : 3;

    urlImage1.value = product.foto1;
    urlImage2.value = product.foto2;
    urlImage3.value = product.foto3;

    currentIdProduct = product.uidProduct;
    idShhalal = product.uidShhalal;
    nameProduct.value = product.nama;
    descriptionProduct.value = product.deskripsi;
    categoryProduct.value = product.kategori;
    noHalalProduct.value = product.nomorSH;
    merkProduct.value = product.merek;
    priceProduct.value = product.harga;
    stockProduct.value = product.stok;
    weightProduct.value = product.berat;

    nameProductTextController.text = nameProduct.value;
    descriptionProductTextController.text = descriptionProduct.value;
    priceProductTextController.text = priceFormatter(priceProduct.value);
    stockProductTextController.text = stockFormatter(stockProduct.value);
    weightProductTextController.text = stockFormatter(weightProduct.value);
  }

  bool isAllDataValid() {
    return urlImage1.isNotEmpty &&
        nameProduct.isNotEmpty &&
        descriptionProduct.isNotEmpty &&
        categoryProduct.isNotEmpty &&
        merkProduct.isNotEmpty &&
        noHalalProduct.isNotEmpty &&
        priceProduct.isNotEmpty &&
        stockProduct.isNotEmpty &&
        weightProduct.isNotEmpty;
  }

  Future<void> insertImage() async {
    final ImagePicker picker = ImagePicker();

    isInsertImageLoading.value = true;

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final size = await pickedFile.length();
      if (size > 2000000) {
        isImageFileTooLarge.value = true;
      } else {
        isImageFileTooLarge.value = false;

        if (countImage.value == 0) {
          urlImage1.value = pickedFile.path;
        } else if (countImage.value == 1) {
          urlImage2.value = pickedFile.path;
        } else if (countImage.value == 2) {
          urlImage3.value = pickedFile.path;
        }
        countImage.value++;
        isImageChanged = true;
      }
    }
    isInsertImageLoading.value = false;
  }

  void deleteImage(int index) {
    if (index == 1) {
      urlImage1.value = '';
    } else if (index == 2) {
      urlImage2.value = '';
    } else if (index == 3) {
      urlImage3.value = '';
    }
    countImage.value--;
    isImageChanged = true;
  }

  void formatPrice(String value) {
    if (value.isNotEmpty) {
      value = value.replaceAll('Rp', '');
      value = value.replaceAll('.', '');
      value = value.replaceAll(',', '');
      value = value.replaceAll(' ', '');
    }
    if (value.isNotEmpty) {
      priceProduct.value = value;
      priceProductTextController.text = priceFormatter(value);
    } else {
      priceProduct.value = '';
      priceProductTextController.clear();
      return;
    }
    update();
  }

  void formatStock(String value) {
    if (value == '0') {
      stockProductTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: stockProductTextController.text.length),
      );
    }
    if (value.isNotEmpty) {
      value = value.replaceAll('.', '');
      value = value.replaceAll(',', '');
      value = value.replaceAll(' ', '');
    }
    if (value.isNotEmpty) {
      stockProduct.value = value;
      stockProductTextController.text = stockFormatter(value);
    } else {
      stockProduct.value = '0';
      stockProductTextController.text = stockProduct.value;
      return;
    }
    update();
  }

  void formatWeight(String value) {
    if (value.isNotEmpty) {
      value = value.replaceAll('.', '');
      value = value.replaceAll(',', '');
      value = value.replaceAll(' ', '');
    }
    if (value.isNotEmpty) {
      weightProduct.value = value;
      weightProductTextController.text = stockFormatter(value);
    } else {
      weightProduct.value = '';
      weightProductTextController.text = weightProduct.value;
      return;
    }
    update();
  }

  String generateImageName(String idUser) {
    final now = DateTime.now();
    final formattedDate =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";

    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final randomString =
        List.generate(4, (index) => chars[random.nextInt(chars.length)]).join();

    return "${idUser}_IMG_${formattedDate}_$randomString.jpg";
  }

  Future<void> getMerkshProduct() async {
    isGetMerkshLoading.value = true;

    final String url =
        'https://sibeux.my.id/project/sihalal/product?method=merksh&category=${categoryProduct.value}';

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      if (listData.isNotEmpty) {
        final list = listData.map((data) {
          return Merksh(
            idSh: data['id_shhalal'],
            categorySh: data['kategori_shhalal'],
            numberSh: data['nomor_shhalal'],
            nameMerkSh: data['merek_shhalal'],
          );
        }).toList();

        listMerkshProduct.value = list;
      } else {
        listMerkshProduct.value = [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error getMerkshProduct: $error');
      }
    } finally {
      isGetMerkshLoading.value = false;
    }
  }

  Future<void> sendDataSellerProduct({required bool isNew}) async {
    isNeedLoading.value = true;

    final userProfileController = Get.find<UserProfileController>();

    const String url = 'https://sibeux.my.id/project/sihalal/seller/product';
    const String imageUploadUrl = 'https://sibeux.my.id/project/sihalal/upload';

    var nameImage1 = '';
    var nameImage2 = '';
    var nameImage3 = '';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(imageUploadUrl));

      if (urlImage1.isNotEmpty && !urlImage1.value.contains('sibeux.my.id')) {
        nameImage1 =
            generateImageName(userProfileController.userData[0].idUser);
        request.files.add(
          await http.MultipartFile.fromPath(
            // 'file[]' adalah array notation
            // php akan menganggap ini sebagai array
            'file[]',
            urlImage1.value,
            filename: nameImage1,
          ),
        );
      }
      if (urlImage2.isNotEmpty && !urlImage2.value.contains('sibeux.my.id')) {
        nameImage2 =
            generateImageName(userProfileController.userData[0].idUser);
        request.files.add(
          await http.MultipartFile.fromPath(
            'file[]',
            urlImage2.value,
            filename: nameImage2,
          ),
        );
      }
      if (urlImage3.isNotEmpty && !urlImage3.value.contains('sibeux.my.id')) {
        nameImage3 =
            generateImageName(userProfileController.userData[0].idUser);
        request.files.add(
          await http.MultipartFile.fromPath(
            'file[]',
            urlImage3.value,
            filename: nameImage3,
          ),
        );
      }

      var responseUpload = http.StreamedResponse(const Stream.empty(), 500);

      if (isImageChanged) {
        responseUpload = await request.send();
      }

      if (responseUpload.statusCode == 200 || !isImageChanged) {
        if (isImageChanged) {
          if (kDebugMode) {
            print('Image berhasil diupload');
          }
        }

        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'method': isNew ? 'new' : 'update',
            'id_user': userProfileController.userData[0].idUser,
            'id_shhalal': idShhalal,
            'id_produk': isNew ? '' : currentIdProduct,
            'foto_produk_1':
                isImageChanged && !urlImage1.value.contains('sibeux.my.id')
                    ? 'https://sibeux.my.id/project/sihalal/uploads/$nameImage1'
                    : urlImage1.value,
            'foto_produk_2': urlImage2.isEmpty
                ? ''
                : isImageChanged && !urlImage2.value.contains('sibeux.my.id')
                    ? 'https://sibeux.my.id/project/sihalal/uploads/$nameImage2'
                    : urlImage2.value,
            'foto_produk_3': urlImage3.isEmpty
                ? ''
                : isImageChanged && !urlImage3.value.contains('sibeux.my.id')
                    ? 'https://sibeux.my.id/project/sihalal/uploads/$nameImage3'
                    : urlImage3.value,
            'nama_produk': nameProduct.value,
            'deskripsi_produk': descriptionProduct.value,
            'harga_produk': priceProduct.value,
            'stok_produk': stockProduct.value,
            'berat_produk': weightProduct.value,
          },
        );

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('Data berhasil dikirim: ${response.body}');
          }

          await Get.find<GetSellerProductController>().getUserProduct(
            email: userProfileController.userData[0].emailuser,
          );
          Get.back();
        } else {
          if (kDebugMode) {
            print('Data gagal dikirim: ${response.body}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Image gagal diupload: ${responseUpload.statusCode}');
        }
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error sendNewSellerProduct: $error');
        print(stackTrace);
      }
    } finally {
      isNeedLoading.value = false;
    }
  }

  Future<void> deleteSellerProduct({required String idProduct}) async {
    final userProfileController = Get.find<UserProfileController>();
    final getSellerProductController = Get.find<GetSellerProductController>();

    const String uri = "https://sibeux.my.id/project/sihalal/seller/product";

    getSellerProductController.isGetProductLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'delete',
          'id_produk': idProduct,
        },
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Data berhasil dihapus: ${response.body}');
        }

        await Get.find<GetSellerProductController>().getUserProduct(
          email: userProfileController.userData[0].emailuser,
        );
      } else {
        if (kDebugMode) {
          print('Gagal menghapus data: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleteSellerProduct: $e');
      }
    } finally {
      getSellerProductController.isGetProductLoading.value = false;
    }
  }

  Future<void> changeViewSellerProduct(
      {required String idProduct, required String visibility}) async {
    final userProfileController = Get.find<UserProfileController>();
    final getSellerProductController = Get.find<GetSellerProductController>();

    const String uri = "https://sibeux.my.id/project/sihalal/seller/product";

    getSellerProductController.isGetProductLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'view',
          'is_ditampilkan': visibility,
          'id_produk': idProduct,
        },
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Data berhasil diperbarui: ${response.body}');
        }

        await Get.find<GetSellerProductController>().getUserProduct(
          email: userProfileController.userData[0].emailuser,
        );
      } else {
        if (kDebugMode) {
          print('Gagal memperbarui data: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error changeViewSellerProduct: $e');
      }
    } finally {
      getSellerProductController.isGetProductLoading.value = false;
    }
  }
}
