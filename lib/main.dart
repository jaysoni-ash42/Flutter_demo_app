import 'package:demo_app/Screen/image_banner.dart';
import 'package:demo_app/Screen/text_section.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter app"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageBanner("assets/images/Icon-192.png"),
            TextSection(Colors.red),
            TextSection(Colors.green),
            TextSection(Colors.white),
            TextSection(Colors.yellow)
          ],
        ),
      ),
    );
  }
}
