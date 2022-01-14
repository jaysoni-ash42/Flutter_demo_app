import 'package:demo_app/Providers/google_sign_provider.dart';
import 'package:demo_app/screens/PostList/post_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/widgets/text_section.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Homecreen extends StatelessWidget {
  const Homecreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleProvider = Provider.of<GoogleSignProvider>(context);
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return PostList();
                  } else {
                    return Container(
                        margin:
                            const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 15.0),
                                child: const CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.transparent,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/Demo.png'),
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(bottom: 15.0),
                              child: TextSection("Hello welcome to the app",
                                  "Login to continue"),
                            ),
                            Expanded(
                              child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size(double.infinity, 50)),
                                      icon: const Icon(
                                        FontAwesomeIcons.google,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        googleProvider.googleLogin();
                                      },
                                      label: const Text("Sign up to google"))),
                            )
                          ],
                        ));
                  }
                })));
  }
}
