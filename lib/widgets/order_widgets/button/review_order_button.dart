import 'package:flutter/material.dart';

class ReviewOrderButton extends StatelessWidget {
  const ReviewOrderButton({
    super.key,
    required this.idPesanan,
  });

  final String idPesanan;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor:
                const Color.fromARGB(255, 196, 130, 23).withOpacity(0.8),
            backgroundColor: Colors.transparent,
            elevation: 0, // Menghilangkan shadow
            splashFactory: InkRipple.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.amber.withOpacity(0.7),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            child: Text(
              'Beri Ulasan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
