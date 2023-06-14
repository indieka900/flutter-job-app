import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';

class ImageUpoader extends ChangeNotifier {
  var uuid = const Uuid();

  final cloudinary = CloudinaryPublic('diyhlasnt', 'n2wofryu');
  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];
  List<File> images = [];

  Future<File?> cropImage(File imageFile) async {
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

      return File(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<String?> uploadImage({
    required File? image,
  }) async {
    try {
      CloudinaryResponse res = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image!.path, folder: 'name'));
      imageUrl = res.secureUrl;
      return res.secureUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<File>> pickImage() async {
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      print(e);
    }
    var image = await cropImage(images[0]);
    uploadImage(image: image);

    return images;
  }
}
