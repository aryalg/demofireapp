import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremember/services/file_service.dart';

import '../../locator.dart';
import '../../models/todo.dart';
import '../../services/database_service.dart';
import '../../services/database_service.dart';

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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FileService _fileService = locator<FileService>();
  FirebaseDataProvider _dataProvider =
      locator<FirebaseDataProvider>();

  File pickedImage;
  String imageLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _formKey,
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
                : Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context)
                                .size
                                .width *
                            0.5,
                        child: Image.file(pickedImage),
                      ),
                      Spacer(),
                      RaisedButton(
                          onPressed: () {
                            setState(() {
                              pickedImage = null;
                            });
                          },
                          child: Text('DELETE IMAGE'))
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
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

  TextFormField _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      validator: (data) {
        if (data.trim().isEmpty) {
          return 'Title cannot be empty';
        }
        return null;
      },
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

  TextFormField _buildDescriptionField() {
    return TextFormField(
      controller: _descController,
      validator: (data) {
        if (data.trim().isEmpty) {
          return 'Description cannot be empty';
        }
        return null;
      },
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

          // Upload image to server and get link
          imageLink =
              await _dataProvider.uploadPhoto(pickedImage);
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
        onPressed: () async {
          addTask();
        },
      ),
    );
  }

  void addTask() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (imageLink != null) {
        Todo taskTobeAdded = Todo(
            description: _descController.text.trim(),
            title: _titleController.text.trim(),
            imageUrl: imageLink);

        await _dataProvider.createNewTask(
            todo: taskTobeAdded);
      } else {
        print('Image is empty');
      }
    }
  }
}
