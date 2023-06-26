import 'package:flutter/material.dart';

import 'cat_squeleton_card.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFAFAFA), 
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              return const CatSqueletonCard();
            },
          ),
        ),
      );
}
