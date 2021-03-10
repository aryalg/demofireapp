import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremember/services/file_service.dart';

import '../../locator.dart';

//TODO allow user to pick image and display the preview in UI
//TODO save new data to firestore (upload image to storage)
class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String title;
  String description;

  TextEditingController _titleController =
      TextEditingController();
  TextEditingController _descController =
      TextEditingController();

  FileService _fileService = locator<FileService>();

  File pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            _buildTitleField(),
            SizedBox(
              height: 20,
            ),
            _buildDescriptionField(),
            SizedBox(
              height: 20,
            ),
            pickedImage == null
                ? Container()
                : Image.file(pickedImage),
            _buildImgSelectButton(),
            SizedBox(
              height: 20,
            ),
            _buildSaveButton(context)
          ],
        ),
      ),
    );
  }

  TextField _buildTitleField() {
    return TextField(
      controller: _titleController,
      onChanged: (value) {
        setState(() {
          title = value;
        });
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "title",
          prefixIcon: Icon(Icons.title)),
    );
  }

  TextField _buildDescriptionField() {
    return TextField(
      controller: _descController,
      onChanged: (value) {
        setState(() {
          description = value;
        });
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
    );
  }

  SizedBox _buildImgSelectButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton.icon(
        icon: Icon(Icons.camera),
        label: Text("Add Image"),
        color: Colors.blue,
        onPressed: () async {
          File image = await _fileService.pickImage(
            ImageSource.gallery,
          );

          setState(() {
            pickedImage = image;
          });
        },
      ),
    );
  }

  SizedBox _buildSaveButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 20.0,
      child: RaisedButton.icon(
        icon: Icon(Icons.save),
        label: Text("Save"),
        color: Colors.blue,
        onPressed: () async {},
      ),
    );
  }
}
