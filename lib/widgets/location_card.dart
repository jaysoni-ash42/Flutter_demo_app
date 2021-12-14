import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String _image;
  final String _title;
  LocationCard(this._image, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
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
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    alignment: Alignment.topLeft,
                    child: Text(
                      _title,
                      style: Theme.of(context).textTheme.headline1,
                    ))),
          ],
        ));
  }
}
