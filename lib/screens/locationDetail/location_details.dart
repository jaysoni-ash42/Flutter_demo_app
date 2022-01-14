import 'package:demo_app/widgets/image_banner.dart';
import 'package:demo_app/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/Models/location.dart';

class LocationDetail extends StatelessWidget {
  final int locationId;

  LocationDetail(this.locationId, {Key? key}) : super(key: key);

  List<Widget> textSection(Location location) {
    return location.facts
        .map((item) => TextSection(item.heading, item.subtitle))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var location = Location.fetchById(locationId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Detail page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ImageBanner(location.image),
          Expanded(
            child: ListView(
              children: [...textSection(location)],
            ),
          ),
        ],
      ),
    );
  }
}
