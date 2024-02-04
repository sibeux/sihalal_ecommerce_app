import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55, // 60% of the screen
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 217, 220, 231),
          width: 2,
        ),
      ),
      child: TextField(
        onChanged: (value) {},
        decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: 'Cari di SiHALAL',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 103, 103, 102),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 18,
            ),
            prefixIconColor: Color.fromARGB(255, 103, 103, 102),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 11.5,
            )),
      ),
    );
  }
}
