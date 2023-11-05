import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../themes/theme.dart';
import 'image_picker_modal.dart';
import 'dart:io';

class ImgPickerElsePhoto extends StatelessWidget {
  const ImgPickerElsePhoto({super.key, required this.pickImage, this.image});
  final Future Function(ImageSource imgSource) pickImage;
  final File? image;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
                child: Container(
                  color: colorsOne.colorScheme.primary,
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                      iconSize: 130,
                      onPressed: () {
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
                      icon: const Icon(Icons.add_photo_alternate_outlined,
                          color: Colors.white)),
                ),
              );
  }
}