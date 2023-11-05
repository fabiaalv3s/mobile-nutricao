import 'package:flutter/material.dart';
import 'package:appnutricao/themes/theme.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModal extends StatelessWidget {
  const ImagePickerModal({super.key, required this.pickImage});

  final Future Function(ImageSource imgSource) pickImage;
  static const ImageSource camera = ImageSource.camera;
  static const ImageSource gallery = ImageSource.gallery;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(colorsTwo.colorScheme.secondary),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(10))),
            onPressed: () {
              pickImage(camera);

              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.photo_camera,
                  size: 50,
                ),
                Text(
                  'Camera',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            )),
        const SizedBox(height: 10),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(colorsTwo.colorScheme.secondary),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(10))),
            onPressed: () {
              pickImage(gallery);
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 50,
                ),
                Text(
                  'Galeria',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            )),
      ]),
    );
  }
}
