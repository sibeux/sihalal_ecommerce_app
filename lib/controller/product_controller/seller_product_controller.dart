import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_seller_product_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/merksh.dart';
import 'package:sihalal_ecommerce_app/models/seller_product.dart';
import 'package:uuid/uuid.dart';

class SellerProductController extends GetxController {
  var countImage = 0.obs;

  var urlImage1 = ''.obs;
  var urlImage2 = ''.obs;
  var urlImage3 = ''.obs;
  var oldUrlImage1 = '';
  var oldUrlImage2 = '';
  var oldUrlImage3 = '';

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
    oldUrlImage1 = product.foto1;
    oldUrlImage2 = product.foto2;
    oldUrlImage3 = product.foto3;

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
    const uuid = Uuid();

    return "IMG_${uuid.v4()}.jpg";
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

  Future<void> deleteImageFromCpanel({
    // sepertinya idProduct tidak berguna
    required String idProduct,
    required String method,
    List<String> deletedImages = const [],
  }) async {
    const String imageDeleteUrl = 'https://sibeux.my.id/project/sihalal/delete';

    var nameImage1 = '';
    var nameImage2 = '';
    var nameImage3 = '';

    try {
      if (method == 'update') {
        if (oldUrlImage1 != urlImage1.value && oldUrlImage1.isNotEmpty) {
          nameImage1 = oldUrlImage1.split('/').last;
        }
        if (oldUrlImage2 != urlImage2.value && oldUrlImage2.isNotEmpty) {
          nameImage2 = oldUrlImage2.split('/').last;
        }
        if (oldUrlImage2 != urlImage3.value && oldUrlImage3.isNotEmpty) {
          nameImage3 = oldUrlImage3.split('/').last;
        }
      } else {
        for (var i = 0; i < deletedImages.length; i++) {
          if (i == 0) {
            nameImage1 = deletedImages[i];
          } else if (i == 1) {
            nameImage2 = deletedImages[i];
          } else if (i == 2) {
            nameImage3 = deletedImages[i];
          }
        }
      }

      final response = await http.post(
        Uri.parse(imageDeleteUrl),
        body: jsonEncode({
          'filenames': [nameImage1, nameImage2, nameImage3],
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200 && data['status'] == 'success') {
        if (kDebugMode) {
          print('Image berhasil dihapus: ${data['message']}');
        }
      } else {
        if (kDebugMode) {
          print('Image gagal dihapus: ${data['message']}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error deleteImageFromCpanel: $error');
      }
    } finally {}
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
      final requestUploadImage =
          http.MultipartRequest('POST', Uri.parse(imageUploadUrl));

      // ** Upload Image
      if (urlImage1.isNotEmpty && !urlImage1.value.contains('sibeux.my.id')) {
        nameImage1 =
            generateImageName(userProfileController.userData[0].idUser);
        requestUploadImage.files.add(
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
        requestUploadImage.files.add(
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
        requestUploadImage.files.add(
          await http.MultipartFile.fromPath(
            'file[]',
            urlImage3.value,
            filename: nameImage3,
          ),
        );
      }

      var responseUploadImage =
          http.StreamedResponse(const Stream.empty(), 500);

      if (isImageChanged) {
        responseUploadImage = await requestUploadImage.send();
      }

      var status = '';

      final responseString = await responseUploadImage.stream.bytesToString();
      if (responseString.isNotEmpty) {
        final jsonResponse = json.decode(responseString);
        status = jsonResponse['uploaded_files'][0]['status'];
      }

      if ((responseUploadImage.statusCode == 200 && status == 'success') ||
          !isImageChanged) {
        if (isImageChanged) {
          if (kDebugMode) {
            print('Image berhasil diupload');
            print(responseString);
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

          if (!isNew) {
            deleteImageFromCpanel(
                idProduct: currentIdProduct, method: 'update');
          }

          Get.back();
        } else {
          if (kDebugMode) {
            print('Data gagal dikirim: ${response.body}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Image gagal diupload: ${responseUploadImage.statusCode}');
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

        final deletedImages = getSellerProductController.sellerProductList
            .where((p0) => p0.uidProduct == idProduct)
            .map((e) => [e.foto1, e.foto2, e.foto3])
            .toList()[0];

        deleteImageFromCpanel(
          idProduct: idProduct,
          method: 'delete',
          deletedImages: deletedImages,
        );

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
