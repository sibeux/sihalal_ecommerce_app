import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      body: const Center(
        child: Text('Favorit'),
      ),
    );
  }
}