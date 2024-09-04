import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Product'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: product.foto1,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }
}
