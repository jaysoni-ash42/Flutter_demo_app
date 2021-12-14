import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String _title;
  final String _body;
  TextSection(this._title, this._body);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 4.0),
            child: Text(
              _title,
              style: Theme.of(context).textTheme.headline1,
            )),
        Container(
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
            child: Text(_body, style: Theme.of(context).textTheme.subtitle1))
      ],
    );
  }
}
