import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_picker_modal.dart';
import 'dart:io';

class ImgPickerIfPhoto extends StatelessWidget {
  const ImgPickerIfPhoto({super.key, required this.pickImage, this.image});
  final Future Function(ImageSource imgSource) pickImage;
  final File? image;
  @override
  Widget build(BuildContext context) {
    return Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                            //modal return
                            builder: (context) {
                              return ImagePickerModal(pickImage: pickImage,);
                            });
                      },
                      child: ClipOval(
                          child: Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ))),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Clique na imagem caso queira alterá-la'),
                ],
              );
  }
}