import 'package:demo_app/Providers/google_sign_provider.dart';
import 'package:demo_app/screens/HomeScreen/home_screen.dart';
import 'package:demo_app/screens/PostList/post_list.dart';
import 'package:demo_app/screens/PostDetail/post_details.dart';
import 'package:demo_app/style.dart';
import 'package:demo_app/Providers/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

const homeroute = "/";
const PostsRoute = '/PostRoute';
const PostDetailRoute = '/Post_detail';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool('darkTheme') ?? false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeManager(isDarkTheme)),
    ChangeNotifierProvider(create: (_) => GoogleSignProvider())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final _themeManager = Provider.of<ThemeManager>(context);
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
        case homeroute:
          screen = const Homecreen();
          break;
        case PostsRoute:
          screen = const PostList();
          break;
        case PostDetailRoute:
          screen = PostDetail(PostId: arguments as String);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
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
