import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Models/post.dart';

Future<List<Post>> getPosts() async {
  try {
    List<Post> listPost = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference PostRef = firestore.collection("location");
    var dataList = await PostRef.get();
    for (var doc in dataList.docs) {
      Map post = doc.data() as Map;
      Post loc = Post(
          id: post["Id"],
          title: post["title"],
          image: post["image"],
          facts: post["facts"] ?? []);
      listPost.add(loc);
    }
    return listPost;
  } catch (e) {
    throw Exception(e);
  }
}

Future<Post> getPostFacts(id) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference PostRef = firestore.collection("location").doc(id);
    var snapShot = await PostRef.get();
    Map data = snapShot.data() as Map;
    Post post = Post(
        id: data["Id"],
        title: data["title"],
        image: data["image"],
        facts: data["facts"]);
    return post;
  } catch (e) {
    throw Exception(e);
  }
}
