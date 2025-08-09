import 'dart:io';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final MeController meController = Get.put(MeController());

  File? _imageFile;

  // Controllers
  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();
  final nipController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final addressController = TextEditingController();

  String? selectedGender; // 'L' or 'P'

  @override
  void initState() {
    super.initState();
    meController.fetchMe().then((_) {
      final profile = meController.profile.value;
      if (profile != null) {
        fullnameController.text = profile.fullname ?? '';
        phoneController.text = profile.phone ?? '';
        nipController.text = profile.nip ?? '';
        placeOfBirthController.text = profile.placeOfBirth ?? '';
        dateOfBirthController.text = profile.dateOfBirth ?? '';
        addressController.text = profile.address ?? '';
        selectedGender = profile.gender;
        setState(() {}); // refresh UI
      }
    });
  }

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

  void _saveProfile() async {
    if (dateOfBirthController.text.isNotEmpty) {
      final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
      if (!dateRegex.hasMatch(dateOfBirthController.text)) {
        Get.snackbar(
          "Error",
          "Tanggal lahir tidak valid, gunakan format YYYY-MM-DD",
        );
        return;
      }
    }
    final profileData = {
      "fullname": fullnameController.text.isEmpty
          ? ''
          : fullnameController.text,
      "phone": phoneController.text.isEmpty ? '' : phoneController.text,
      "nip": nipController.text.isEmpty ? '' : nipController.text,
      "placeOfBirth": placeOfBirthController.text.isEmpty
          ? ''
          : placeOfBirthController.text,
      "dateOfBirth": dateOfBirthController.text.isEmpty
          ? null
          : dateOfBirthController.text,
      "address": addressController.text,
      "gender": selectedGender,
    };

    // Hapus key dengan value null supaya gak kirim password kosong
    profileData.removeWhere((key, value) => value == null);

    if (meController.profile.value == null) {
      Get.snackbar("Error", "Profil belum terload");
      return;
    }

    final id = meController.profile.value!.id;
    // Panggil updateProfile dari controller
    await meController.updateProfile(
      id: id,
      input: profileData,
      profilePhoto: _imageFile,
    );

    if (meController.isSuccess.value) {
      Get.snackbar("Sukses", "Profil berhasil diperbarui");
      // Jika perlu refresh data profil:
      await meController.fetchMe();
    } else {
      Get.snackbar("Error", meController.errorMessage.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Edit Profile"),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: ListView(
        children: [
          Container(
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
                            : const AssetImage('assets/images/placeholder.png')
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

                _buildTextField(fullnameController, "Nama Lengkap"),
                _buildTextField(nipController, "NIP"),
                _buildTextField(
                  phoneController,
                  "No. Telepon",
                  inputType: TextInputType.phone,
                ),
                _buildTextField(placeOfBirthController, "Tempat Lahir"),
                _buildDateField(dateOfBirthController, "Tanggal Lahir"),
                _buildTextField(addressController, "Alamat", maxLines: 4),

                const SizedBox(height: 16),
                const Text("Jenis Kelamin"),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: const [
                    DropdownMenuItem(value: "L", child: Text("Laki-laki")),
                    DropdownMenuItem(value: "P", child: Text("Perempuan")),
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedGender = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType inputType = TextInputType.text,
    bool isPassword = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            obscureText: isPassword,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate:
                    DateTime.tryParse(controller.text) ?? DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  controller.text = picked.toIso8601String().substring(
                    0,
                    10,
                  ); // Format: YYYY-MM-DD
                });
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Pilih Tanggal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
