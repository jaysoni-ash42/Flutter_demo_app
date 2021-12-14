import 'package:demo_app/screens/locationList/location_list.dart';
import 'package:demo_app/screens/locationDetail/location_details.dart';
import 'package:demo_app/style.dart';
import 'package:flutter/material.dart';

const locationsRoute = '/';
const locationDetailRoute = '/location_detail';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      theme: _theme(),
      initialRoute: "/",
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case locationsRoute:
          screen = LocationList();
          break;
        case locationDetailRoute:
          screen = LocationDetail(arguments as int);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(titleTextStyle: appBarTextTheme),
        textTheme: const TextTheme(
            headline1: headingTextStyle, subtitle1: subTitleTextStyle));
  }
}
