import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        maxHeightDiskCache: 300,
        maxWidthDiskCache: 300,
        filterQuality: FilterQuality.low,
        // placeholder: (context, url) => Image.asset(
        //   'assets/images/placeholder_cover_music.png',
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
