import 'package:flutter/material.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    super.key,
    required this.iconBar,
    required this.numOfItems,
    required this.press,
  });

  final IconData iconBar;
  final int numOfItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        onTap: press,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 46,
              width: 46,
              child: Icon(
                iconBar,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            if (numOfItems != 0) RedNoteIcon(numOfItems: numOfItems)
          ],
        ),
      ),
    );
  }
}

class RedNoteIcon extends StatelessWidget {
  const RedNoteIcon({
    super.key,
    required this.numOfItems,
  });

  final int numOfItems;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 3,
      right: 3,
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            '$numOfItems',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
