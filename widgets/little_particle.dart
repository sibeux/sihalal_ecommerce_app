import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GreyLined extends StatelessWidget {
  const GreyLined({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      color: Colors.grey[200],
    );
  }
}

class InkButton extends StatelessWidget {
  const InkButton({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor(color),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.3),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
