import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File? pickedImageFile) imagePickFn;

  const UserImagePicker(this.imagePickFn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;
  File? newPhoto;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    final XFile? pickedImageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = pickedImageFile;
    });
    newPhoto = File(_pickedImage!.path);
    widget.imagePickFn(newPhoto);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: newPhoto == null ? null : FileImage(newPhoto!),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
