import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iremember/config/paths.dart';
import 'package:iremember/models/todo.dart';

class FirebaseDataProvider {
  final FirebaseStorage firebaseStorage =
      FirebaseStorage.instance;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> createNewTask({Todo todo}) async {
    try {
      DocumentReference ref =
          db.collection(Paths.taskPath).doc();

      Map<String, dynamic> data = todo.toMap();

      await ref.set(data);
    } catch (err) {
      print('failed to save user details:: $err');
      throw err;
    }
  }
}
