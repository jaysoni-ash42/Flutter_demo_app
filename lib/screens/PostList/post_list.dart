import 'package:demo_app/Api/postapi.dart';
import 'package:demo_app/Models/post.dart';
import 'package:demo_app/Providers/google_sign_provider.dart';
import 'package:demo_app/main.dart';
import 'package:demo_app/Providers/theme_manager.dart';
import 'package:demo_app/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Post> PostList = [];
  var loading = true;

  void onPostTap(BuildContext context, String id) {
    Navigator.pushNamed(context, PostDetailRoute, arguments: id);
  }

  void fetchData() async {
    PostList = await getPosts();
    if (PostList.isNotEmpty) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeManager = Provider.of<ThemeManager>(context);
    final googleProvider = Provider.of<GoogleSignProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post App"),
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
      body: loading
          ? Container(
              height: MediaQuery.of(context).size.height - 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  _themeManager.darkTheme ? Colors.white : Colors.black,
                ),
              ),
            )
          : ListView(
              children: PostList.map((item) => InkWell(
                  onTap: () => onPostTap(context, item.id),
                  child: PostCard(item.image, item.title))).toList(),
            ),
    );
  }
}
