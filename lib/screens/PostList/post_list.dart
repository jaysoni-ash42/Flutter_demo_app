import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Api/postapi.dart';
import 'package:demo_app/Providers/google_sign_provider.dart';
import 'package:demo_app/helper/generateRandomNumber.dart';
import 'package:demo_app/main.dart';
import 'package:demo_app/Providers/theme_manager.dart';
import 'package:demo_app/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  File? _image;
  String? _title, _description;
  bool isButtonActive = false;
  bool loading = false;

  void onPostTap(BuildContext context, String id) {
    Navigator.pushNamed(context, postDetailRoute, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final _themeManager = Provider.of<ThemeManager>(context);
    final googleProvider = Provider.of<GoogleSignProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: const Icon(Icons.account_circle)),
          Text(googleProvider.user?.displayName ?? "Post App")
        ]),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidSun),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("location").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs
                  .map((item) => InkWell(
                      onTap: () => onPostTap(context, item["id"]),
                      child: PostCard(item["image"], item["title"])))
                  .toList(),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height - 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  _themeManager.darkTheme ? Colors.white : Colors.black,
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showUploadDialog(context),
          backgroundColor: Colors.blueAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }

  Future<File?> _clickupload() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) return File(image.path);
  }

  void _showUploadDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: loading ? false : true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                              constraints:
                                  const BoxConstraints.expand(height: 200.0),
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/placeholder.jpeg",
                                      fit: BoxFit.cover,
                                    )),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.add_photo_alternate,
                                size: 30.0,
                                color: _image != null
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              onPressed: () async {
                                var image = await _clickupload();

                                setState(() {
                                  _image = image;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  hintText: 'Enter a Title',
                                  labelText: "Title"),
                              onChanged: (text) {
                                setState(() {
                                  _title = text;
                                });
                              },
                              autofocus: false)),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintText: 'Hit a Description',
                                labelText: "Description",
                              ),
                              onChanged: (text) {
                                setState(() {
                                  _description = text;
                                });
                              },
                              maxLines: null,
                              autofocus: false)),
                      Container(
                          child: loading
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                          onSurface: Colors.blueAccent),
                                      onPressed: _image != null &&
                                              _title != null &&
                                              _description != null
                                          ? () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              bool result = await uploadPost(
                                                  _image!,
                                                  getRandomString(20),
                                                  _title!,
                                                  _description!);
                                              if (result) {
                                                Navigator.pop(context);
                                              }
                                            }
                                          : null,
                                      child: const Text("Upload"))))
                    ],
                  )));
        });
      }).then((value) => setState(() {
        _image = null;
        loading = false;
      }));
}
