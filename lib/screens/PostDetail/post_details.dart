import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Providers/theme_manager.dart';
import 'package:demo_app/widgets/image_banner.dart';
import 'package:demo_app/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  final String postId;
  const PostDetail({Key? key, required this.postId}) : super(key: key);
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeManager>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post Detail page"),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("location")
                .where("id", isEqualTo: widget.postId)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ImageBanner(snapshot.data?.docs[0].data()["image"]),
                    Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: TextSection(
                                snapshot.data?.docs[0].data()["title"],
                                snapshot.data?.docs[0].data()["description"]))),
                  ],
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height - 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      themeProvider.darkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }
            }));
  }
}
