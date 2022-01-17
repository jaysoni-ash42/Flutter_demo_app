import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<bool> uploadPost(
    File image, String id, String title, String description) async {
  try {
    final ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child('${DateTime.now().toIso8601String() + image.path}');
    final result = await ref.putFile(image);
    final fileUrl = await result.ref.getDownloadURL();
    CollectionReference location =
        FirebaseFirestore.instance.collection("location");
    DocumentReference doc = await location.add({
      "id": id,
      "image": fileUrl,
      "title": title,
      "description": description
    });
    if (doc != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception(e);
  }
}
