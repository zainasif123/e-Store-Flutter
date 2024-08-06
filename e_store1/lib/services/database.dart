import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future<void> addUserInfo(Map<String, dynamic> infoUser, String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("users").doc(id).set(infoUser);
  }

  Future<void> addProduct(
      Map<String, dynamic> infoProduct, String categoryname) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection(categoryname).add(infoProduct);
  }

  Stream<QuerySnapshot> getProduct(String category) {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }
}
