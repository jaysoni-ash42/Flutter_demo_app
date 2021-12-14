import 'package:demo_app/Models/location.dart';
import 'package:demo_app/main.dart';
import 'package:demo_app/widgets/location_card.dart';
import 'package:flutter/material.dart';

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locations = Location.fetchAll();
    void _onLocationTap(BuildContext context, int id) {
      Navigator.pushNamed(context, locationDetailRoute, arguments: id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Locations"),
        centerTitle: true,
      ),
      body: ListView(
        children: locations
            .map((item) => InkWell(
                onTap: () => _onLocationTap(context, item.id),
                child: LocationCard(item.image, item.title)))
            .toList(),
      ),
    );
  }
}
