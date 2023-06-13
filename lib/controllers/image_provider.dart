// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_nodejs_app/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class ImageUpoader extends ChangeNotifier {
  var uuid = const Uuid();
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);
    print(_imageFile?.path);
    if (_imageFile != null) {
      // Crop the image

      _imageFile = await cropImage(_imageFile);
      if (_imageFile != null) {
        imageFil.add(_imageFile.path);
        print('Here is the image path ${_imageFile.path}');
        imageUpload(_imageFile);
        imagePath = _imageFile.path;
      } else {
        print('no');
        return;
      }
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    // Crop the image using image_cropper package
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 600,
      maxHeight: 800,
      compressQuality: 80,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'JobApp Cropper',
          toolbarColor: Color(kLightBlue.value),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio5x4,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'JobApp Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      notifyListeners();
      croppedFile.path == "HereJoseph";
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<String?> imageUpload(XFile upload) async {
    File image = File(upload.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child('JobApp')
        .child('${uuid.v1()}.jpg');
    await ref.putFile(image);
    imageUrl = await ref.getDownloadURL();
    print(imageUrl);
    return imageUrl;
  }
}
