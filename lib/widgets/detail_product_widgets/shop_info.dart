import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ShopInfo extends StatelessWidget {
  const ShopInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://raw.githubusercontent.com/sibeux/cybeat_music_player/refs/heads/master/assets/images/cybeat_splash.png',
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                  maxHeightDiskCache: 150,
                  maxWidthDiskCache: 150,
                  filterQuality: FilterQuality.low,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/placeholder_cover_music.png',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/placeholder_cover_music.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 25,
                      width: double.infinity,
                      child: const Text(
                        'RedDennis',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 25,
                        width: double.infinity,
                        child: Text(
                          'Kabupaten Jember',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.8),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 25,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_border,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '4.5',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: HexColor('#3f44a6'),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Penilaian',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 25,
                      width: double.infinity,
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_grocery_store_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '146 Produk',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: HexColor('#3f44a6'),
                    width: 1.5,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: Text(
                  'Lihat Toko',
                  style: TextStyle(
                    color: HexColor('#3f44a6'),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
