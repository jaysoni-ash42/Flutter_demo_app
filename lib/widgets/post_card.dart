import 'package:flutter/material.dart';

import '../style.dart';

class PostCard extends StatelessWidget {
  final String _image;
  final String _title;
  PostCard(this._image, this._title);

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
              child: Image.network(
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_title,
                              style: const TextStyle(
                                fontFamily: fontDefaultName,
                                fontWeight: FontWeight.w300,
                                fontSize: largeTextSize,
                                color: Colors.white,
                              )),
                          Container(
                            child: const Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            margin: const EdgeInsets.only(right: 30.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 6),
                          )
                        ]))),
          ],
        ));
  }
}
