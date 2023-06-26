import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/cat.dart';
import 'widgets/cat_info_box.dart';

class CatDetailsScreen extends StatelessWidget {
  const CatDetailsScreen({
    super.key,
    required this.cat,
  });

  final Cat cat;

  static const imgeUrl = 'https://cdn2.thecatapi.com/images/{imageId}.jpg';
  static const errorImage =
      'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg';

  Padding _buildBody(MediaQueryData mq) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imgeUrl.replaceAll(
                '{imageId}',
                cat.referenceImageId ?? 'HOrX5gwLS',
              ),
              height: mq.size.height * 0.56,
              width: double.infinity,
              placeholder: (context, url) => Container(
                padding: const EdgeInsets.all(20.0),
                width: 20,
                height: 20,
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Image.network(
                errorImage,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CatInfoBox(cat: cat),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
        backgroundColor: Colors.purpleAccent.withOpacity(0.6),
      ),
      body: _buildBody(mq),
    );
  }
}
