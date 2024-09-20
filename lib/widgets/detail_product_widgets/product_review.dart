import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({
    super.key,
    required this.jumlahRating,
    required this.jumlahUlasan,
    required this.rating,
  });

  final String rating, jumlahRating, jumlahUlasan;

  @override
  Widget build(BuildContext context) {
    final rate = rating == '0.0000' ? '0.0' : ('${double.parse(rating)}');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  'Ulasan Produk',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.values[5],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  'Lihat Semua',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: HexColor('#3f44a6'),
                    fontSize: 15,
                    fontWeight: FontWeight.values[5],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 25,
                  color: Colors.amber,
                ),
                const SizedBox(width: 5),
                Row(
                  children: [
                    Text(
                      rate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$jumlahRating penilaian',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      ' • ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$jumlahUlasan ulasan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
