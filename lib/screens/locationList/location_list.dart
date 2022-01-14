import 'package:demo_app/Models/location.dart';
import 'package:demo_app/Providers/google_sign_provider.dart';
import 'package:demo_app/main.dart';
import 'package:demo_app/Providers/theme_manager.dart';
import 'package:demo_app/widgets/location_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationList extends StatelessWidget {
  LocationList({Key? key}) : super(key: key);

  var locations = Location.fetchAll();

  void onLocationTap(BuildContext context, int id) {
    Navigator.pushNamed(context, locationDetailRoute, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final _themeManager = Provider.of<ThemeManager>(context);
    final googleProvider = Provider.of<GoogleSignProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              _themeManager.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              googleProvider.googleLogout();
            },
          ),
        ],
      ),
      body: ListView(
        children: locations
            .map((item) => InkWell(
                onTap: () => onLocationTap(context, item.id),
                child: LocationCard(item.image, item.title)))
            .toList(),
      ),
    );
  }
}
