
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'image_picker_ifphoto.dart';
import 'image_picker_elsephoto.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

File? selectedImage;
File? newImage;
File? imageStateHelper;

class _MyImagePickerState extends State<MyImagePicker> {
  File? image = imageStateHelper;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      final String path =
      await getApplicationDocumentsDirectory().then((value) => value.path);
      final imageTemporary = File(image.path);
      newImage =
          await imageTemporary.copy('$path/Fotos - ${DateTime.now()}.jpg');
      setState(() {
        selectedImage = newImage;
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return image != null
        ? ImgPickerIfPhoto(
            pickImage: pickImage,
            image: image,
          )
        : ImgPickerElsePhoto(
            pickImage: pickImage,
            image: image,
          );
  }
}
