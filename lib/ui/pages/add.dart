import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremember/enums/viewstate.dart';
import 'package:iremember/ui/pages/base_screen.dart';
import 'package:iremember/viewmodels/create_item_view_model.dart';

//TODO allow user to pick image and display the preview in UI
//TODO save new data to firestore (upload image to storage)

class AddPage extends StatelessWidget {
  final TextEditingController _titleController =
      TextEditingController();
  final TextEditingController _descController =
      TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Colors.blueAccent,
      ),
      body: BaseScreen<CreateItemModel>(
        builder: (context, model, builder) {
          if (model.state == ViewState.Busy) {
            return Container();
          } else {
            return Form(
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
                  model.pickedImage == null
                      ? Container()
                      : Row(
                          children: [
                            Container(
                              width: 200,
                              child: Image.file(
                                  model.pickedImage),
                            ),
                            Spacer(),
                            RaisedButton(
                                onPressed: () {
                                  model.deletePickedImage();
                                },
                                child: Text('DELETE IMAGE'))
                          ],
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildImgSelectButton(model),
                  SizedBox(
                    height: 20,
                  ),
                  _buildSaveButton(model, context)
                ],
              ),
            );
          }
        },
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
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
    );
  }

  SizedBox _buildImgSelectButton(CreateItemModel model) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton.icon(
        icon: Icon(Icons.camera, color: Colors.white),
        label: Text(
          "Add Image",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
        onPressed: () async {
          // Upload image to server and get link
          model.pickImage(imageSource: ImageSource.gallery);
        },
      ),
    );
  }

  SizedBox _buildSaveButton(
      CreateItemModel model, BuildContext context) {
    return SizedBox(
      height: 50,
      width: 20.0,
      child: RaisedButton.icon(
        icon: Icon(Icons.save, color: Colors.white),
        label: Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
        onPressed: () async {
          addTask(model);
        },
      ),
    );
  }

  void addTask(CreateItemModel model) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      model.createNewTask(
        description: _descController.text,
        title: _titleController.text,
      );
    }
  }
}
