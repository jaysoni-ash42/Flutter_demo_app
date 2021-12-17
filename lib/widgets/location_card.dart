import 'package:flutter/material.dart';

import '../style.dart';

class LocationCard extends StatelessWidget {
  final String _image;
  final String _title;
  LocationCard(this._image, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(height: 200.0),
              child: Image.asset(
                _image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 0,
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(_title,
                        style: const TextStyle(
                          fontFamily: fontDefaultName,
                          fontWeight: FontWeight.w300,
                          fontSize: largeTextSize,
                          color: Colors.white,
                        )))),
          ],
        ));
  }
}
