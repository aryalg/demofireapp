import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iremember/common/tools.dart';
import 'package:iremember/config/paths.dart';
import 'package:iremember/models/todo.dart';
import 'package:uuid/uuid.dart';

import '../models/todo.dart';
import '../models/todo.dart';
import '../models/todo.dart';

class FirebaseDataProvider {
  final FirebaseStorage firebaseStorage =
      FirebaseStorage.instance;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Todo>> getAllTodoList() async {
    Tools.showLoadingModal();
    try {
      QuerySnapshot querySnapshot =
          await db.collection(Paths.taskPath).get();

      List<Todo> todos = List<Todo>.from(querySnapshot.docs
          .map((snapshot) => Todo.fromFirebase(snapshot)));

      Tools.dismissLoadingModal();

      return todos;

      // debugger();

    } catch (err) {
      print('Failed to get items');
      Tools.dismissLoadingModal();
      throw err;
    }
  }

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

  Future<String> uploadPhoto(File image) async {
    try {
      if (image != null) {
        var uuid = Uuid().v4();

        StorageReference storageReference =
            firebaseStorage.ref().child('tasks/$uuid');

        StorageUploadTask storageUploadTask =
            storageReference.putFile(image);

        StorageTaskSnapshot storageTaskSnapshot =
            await storageUploadTask.onComplete;

        var url =
            await storageTaskSnapshot.ref.getDownloadURL();

        return url;
      }

      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
