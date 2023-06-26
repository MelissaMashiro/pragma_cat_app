import 'package:flutter/material.dart';

class CatSqueletonCard extends StatelessWidget {
  const CatSqueletonCard({
    super.key,
  });

  static const imgeUrl = 'https://cdn2.thecatapi.com/images/{imageId}.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9.0),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              )),
              height: 80.0,
              width: 80.0,
            ),
          ),
          const SizedBox(width: 15.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const LoadingGradientLine(
                  heihgt: 13,
                  width: 160,
                ),
                const SizedBox(height: 15.0),
                const LoadingGradientLine(
                  heihgt: 9,
                  width: 220,
                ),
                const SizedBox(height: 5.0),
                const LoadingGradientLine(
                  heihgt: 9,
                  width: 200,
                ),
                const SizedBox(height: 5.0),
                const LoadingGradientLine(
                  heihgt: 9,
                  width: 198,
                ),
                const SizedBox(height: 5.0),
                const LoadingGradientLine(
                  heihgt: 9,
                  width: 150,
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: const [
                    LoadingGradientLine(
                      heihgt: 13,
                      width: 80,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    LoadingGradientLine(
                      heihgt: 13,
                      width: 80,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingGradientLine extends StatelessWidget {
  const LoadingGradientLine({
    super.key,
    required this.width,
    required this.heihgt,
  });
  final double width;
  final double heihgt;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.grey.withOpacity(0.5),
              Colors.white,
            ],
          )),
      height: heihgt,
      width: width,
    );
  }
}
