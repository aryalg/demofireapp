import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import './ui/pages/home.dart';
import 'locator.dart';

/* 
Please complete the tasks listed in TODOs in different files
  
  In this app user should be able to Save a list of items
  with image (should be able to take a picture or select existing one from gallery), 
  title and description in firestore database, with image being uploaded to firebase storage.

  TODO 1. Integrate a firebase firestore and storage
  TODO 2. Integrate a state management solution you know best

  (optional) -> Theme and style as you prefer to show quality work

  Checkout home.dart and add.dart for TODOs.

 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  return runApp(IRememberApp());
}

class IRememberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IRemember',
      builder: EasyLoading.init(),
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      routes: {
        "/": (_) => HomePage(),
      },
    );
  }
}
