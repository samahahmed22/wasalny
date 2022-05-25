// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasalny/styles/colors.dart';

class ImagePickerField extends StatefulWidget {
  String? oldImage;
  ImagePickerField(this.pickImage, this.oldImage);
  final void Function(File? pickedImage) pickImage;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  @override
  File? pickedImageFile;
  ImagePicker picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 150,
    );
    if (pickedImage != null) {
      setState(() {
        pickedImageFile = File(pickedImage.path);
      });

      widget.pickImage(pickedImageFile);
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Select a photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  label: Text("Camera"),
                ),
                TextButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  label: Text("Gallery"),
                ),
              ])
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80.0,
          backgroundImage: pickedImageFile == null
              ? widget.oldImage == null
                  ? AssetImage('assets/images/default-profile-picture.png')
                      as ImageProvider
                  : NetworkImage(widget.oldImage!)
              : FileImage(File(pickedImageFile!.path)),
        ),
        Positioned(
          bottom: 5.0,
          right: 5.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: CircleAvatar(
              backgroundColor: MyColors.primaryColor,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
