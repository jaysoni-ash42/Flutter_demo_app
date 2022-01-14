import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credentials);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future googleLogout() async {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
