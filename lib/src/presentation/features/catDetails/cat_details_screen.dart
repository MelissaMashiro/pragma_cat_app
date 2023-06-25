import 'package:flutter/material.dart';

import '../../../domain/entities/cat.dart';

class CatDetailsScreen extends StatelessWidget {
  const CatDetailsScreen({
    super.key,
    required this.catDetails,
  });

  final Cat catDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('catito lelgado: ${catDetails.name}'),
      ),
    );
  }
}
