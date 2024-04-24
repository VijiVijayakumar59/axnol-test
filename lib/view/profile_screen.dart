// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:axnoltest/view/widgets/constant_height.dart';
import 'package:axnoltest/view/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              )),
          title: const Center(child: Text('Edit Profile')),
          actions: const [
            Icon(
              Icons.more_vert_rounded,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: getImageFromCamera,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          child: _image != null
                              ? ClipOval(
                                  child: Image.file(
                                    _image!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 70,
                          right: 25,
                          child: IconButton(
                            onPressed: getImageFromCamera,
                            icon: const Icon(Icons.camera_alt),
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const ConstantHeight(size: 0.02),
                const CustomTextFieldWidget(label: "First Name *"),
                const ConstantHeight(size: 0.02),
                const CustomTextFieldWidget(label: "Last Name *"),
                const ConstantHeight(size: 0.02),
                const CustomTextFieldWidget(label: "Mobile Number *"),
                const ConstantHeight(size: 0.02),
                const CustomTextFieldWidget(label: "Password *"),
                const ConstantHeight(size: 0.02),
                const CustomTextFieldWidget(label: "Address *"),
                const ConstantHeight(size: 0.02),
                const CustomTextFieldWidget(
                  label: "Detail *",
                  maxLines: 4,
                ),
                const ConstantHeight(size: 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
