import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tools {
  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      backgroundColor: Colors.red,
      msg: 'Error: $message',
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 3,
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      backgroundColor: Colors.green,
      msg: 'Success: $message',
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
    );
  }

  static void showLoadingModal() {
    EasyLoading.show(
      status: '',
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.custom,
    );
  }

  static void dismissLoadingModal() {
    EasyLoading.dismiss();
  }
}
