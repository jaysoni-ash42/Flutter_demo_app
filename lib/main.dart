import 'package:demo_app/screens/locationList/location_list.dart';
import 'package:demo_app/screens/locationDetail/location_details.dart';
import 'package:demo_app/style.dart';
import 'package:demo_app/theme_manager.dart';
import 'package:flutter/material.dart';

const locationsRoute = '/';
const locationDetailRoute = '/location_detail';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();
bool isDark = false;

bool chnageTheme() {
  isDark = !isDark;
  return isDark;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: _themeManager.themeMode,
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
      return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
              appBar: AppBar(
                title: const Text("Location App"),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.brightness_6),
                    onPressed: () {
                      _themeManager.toggleTheme(chnageTheme());
                    },
                  )
                ],
              ),
              body: screen));
    };
  }

  ThemeData _lightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(titleTextStyle: appBarTextTheme),
        textTheme: const TextTheme(
            headline1: lightModeHeadingTextStyle,
            subtitle1: lightModeSubTitleTextStyle));
  }

  ThemeData _darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(titleTextStyle: appBarTextTheme),
        textTheme: const TextTheme(
            headline1: darkModeHeadingTextStyle,
            subtitle1: darkModeSubTitleTextStyle));
  }
}
