import 'dart:io';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class SettingEditView extends StatefulWidget {
  const SettingEditView({super.key});

  @override
  State<SettingEditView> createState() => _SettingEditViewState();
}

class _SettingEditViewState extends State<SettingEditView> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Edit Setting"),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: ListView(
        children: [
          // Header
          Container(
            height: 10.h,
            decoration: BoxDecoration(
              color: OprimaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Form Section
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 32.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : const AssetImage(
                                      'assets/images/placeholder.png',
                                    )
                                    as ImageProvider,
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text("First Name"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  const Text("Last Name"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  const Text("Phone Number"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  const Text("Gender"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  const Text("Birthday"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  const Text("Password"),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
