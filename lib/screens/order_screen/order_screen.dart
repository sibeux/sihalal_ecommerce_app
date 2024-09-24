import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      body: const Center(
        child: Text('Pesanan'),
      ),
    );
  }
}
