import 'package:demo_app/widgets/image_banner.dart';
import 'package:demo_app/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/Models/location.dart';

class LocationDetail extends StatelessWidget {
  final int locationId;

  const LocationDetail(this.locationId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var location = Location.fetchById(locationId);

    List<Widget> textSection(Location location) {
      return location.facts
          .map((item) => TextSection(item.heading, item.subtitle))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
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