import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremember/common/tools.dart';
import 'package:iremember/locator.dart';
import 'package:iremember/models/todo.dart';
import 'package:iremember/services/database_service.dart';
import 'package:iremember/services/file_service.dart';
import 'package:iremember/viewmodels/base_model.dart';

class CreateItemModel extends BaseModel {
  String _uploadedImage;

  File _pickedImage;

  String get uploadedImage => _uploadedImage;

  File get pickedImage => _pickedImage;

  FileService _fileService = locator<FileService>();
  FirebaseDataProvider _dataProvider =
      locator<FirebaseDataProvider>();

  void deletePickedImage() {
    _pickedImage = null;
    notifyListeners();
  }

  void pickImage(
      {ImageSource imageSource =
          ImageSource.gallery}) async {
    File image = await _fileService.pickImage(
      imageSource,
    );
    _pickedImage = image;
    uploadImage();
    notifyListeners();
  }

  void uploadImage() async {
    Tools.showLoadingModal();
    try {
      _uploadedImage =
          await _dataProvider.uploadPhoto(pickedImage);
      Tools.dismissLoadingModal();
    } catch (err) {
      Tools.dismissLoadingModal();
      Tools.showErrorToast('Failed to Upload image');
    }
  }

  void createNewTask(
      {String title, String description}) async {
    if (uploadedImage != null) {
      Todo taskTobeAdded = Todo(
          description: description,
          title: title,
          imageUrl: uploadedImage);
      try {
        Tools.showLoadingModal();
        await _dataProvider.createNewTask(
            todo: taskTobeAdded);

        Tools.dismissLoadingModal();
        Get.back(
          result: true,
        );
      } catch (err) {
        Tools.dismissLoadingModal();
      }
    } else {
      Tools.showErrorToast('Please attach Image');
      print('Image is empty');
    }
  }
}
