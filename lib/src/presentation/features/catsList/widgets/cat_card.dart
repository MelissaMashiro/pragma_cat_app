import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/named_route.dart';
import '../../../../domain/entities/cat.dart';

class CatCard extends StatelessWidget {
  const CatCard({
    super.key,
    required this.catito,
  });

  final Cat catito;

  static const imgeUrl = 'https://cdn2.thecatapi.com/images/{imageId}.jpg';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        NamedRoute.catDetails,
        arguments: {
          'catDetails': catito,
        },
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.purpleAccent.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9.0),
              child: CachedNetworkImage(
                imageUrl: imgeUrl.replaceAll(
                  '{imageId}',
                  catito.referenceImageId ?? 'HOrX5gwLS',
                ),
                fit: BoxFit.cover,
                height: 80.0,
                width: 80.0,
                placeholder: (context, url) => Container(
                  padding: const EdgeInsets.all(20.0),
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.network(
                    'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg'),
              ),
            ),
            const SizedBox(width: 15.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    catito.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  Text('${catito.description.substring(0, 75)}...'),
                  Row(
                    children: [
                      SizedBox(
                        width: 144.0,
                        child: Row(
                          children: [
                            const Text(
                              'Country: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                catito.origin,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Intelligence: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            '${catito.intelligence}',
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
