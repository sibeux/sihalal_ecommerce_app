import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReviewShimmer extends StatelessWidget {
  const ReviewShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    height: 35,
                    width: 35,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[300],
                      child: const Text(
                        'Uchida Takeshi',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.grey[400],
                          ),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '• ' 'Memuat...',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.grey[300],
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Text(
                'Suka',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
