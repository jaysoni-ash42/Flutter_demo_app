import 'package:demo_app/Api/Postapi.dart';
import 'package:demo_app/Providers/theme_manager.dart';
import 'package:demo_app/widgets/image_banner.dart';
import 'package:demo_app/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/Models/post.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  final String PostId;
  const PostDetail({Key? key, required this.PostId}) : super(key: key);
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  var loading = true;
  late Post post;

  void init() async {
    post = await getPostFacts(widget.PostId);
    if (Post != null) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  List<Widget> textSection(Post post) {
    return post.facts
        .map((item) => TextSection(item["heading"], item["subTitle"]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail page"),
        centerTitle: true,
      ),
      body: loading
          ? Container(
              height: MediaQuery.of(context).size.height - 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  themeProvider.darkTheme ? Colors.white : Colors.black,
                ),
              ),
            )
          : Column(
              children: [
                ImageBanner(post.image),
                Expanded(
                  child: ListView(
                    children: [...textSection(post)],
                  ),
                ),
              ],
            ),
    );
  }
}
