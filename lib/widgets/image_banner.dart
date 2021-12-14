import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String image;
  ImageBanner(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 200.0),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
