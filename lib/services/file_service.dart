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

      return image;
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
