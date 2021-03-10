import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FileService {
  String userId = Uuid().v4();

  Future<File> pickImage(ImageSource imageSource) async {
    try {
      File image = await ImagePicker.pickImage(
          source: imageSource, maxHeight: 500);

      if (image == null) {
        return null;
      }

      if (image != null) {
        image = await _cropImage(image);
      }

      if (image == null) {
        return null;
      }

      return await _compareImage(image);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<File> _compareImage(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Im.Image imageFile =
        Im.decodeImage(file.readAsBytesSync());

    final compressedImageFile =
        File('$path/img_$userId.jpg')
          ..writeAsBytesSync(
              Im.encodeJpg(imageFile, quality: 70));

    return compressedImageFile;
  }

  Future<File> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      compressQuality: 50,
      compressFormat: ImageCompressFormat.png,
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
            ]
          : [
              CropAspectRatioPreset.square,
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile != null) {
      return croppedFile;
    }

    return null;
  }
}
