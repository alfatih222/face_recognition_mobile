import 'dart:io';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/components/widgets/select_field.dart';
import 'package:facerecognition/components/widgets/text_field.dart';
import 'package:facerecognition/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MultiStepSekolahView extends StatefulWidget {
  const MultiStepSekolahView({super.key});

  @override
  State<MultiStepSekolahView> createState() => _MultiStepSekolahViewState();
}

class _MultiStepSekolahViewState extends State<MultiStepSekolahView> {
  final settingController = Get.put(SettingController());
  int _step = 0;
  final List<String> jamList = List.generate(24, (index) {
    final hour = index.toString().padLeft(2, '0');
    return "$hour:00";
  });

  // Controllers untuk semua input
  final namaController = TextEditingController();
  final npsnController = TextEditingController();
  final teleponController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final periodeController = TextEditingController();
  final alamatController = TextEditingController();
  final kotaController = TextEditingController();
  final provinsiController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kelurahanController = TextEditingController();
  final kodePosController = TextEditingController();
  final jamMasukController = TextEditingController();
  final jamPulangController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final radiusController = TextEditingController();

  File? logoFile;
  File? backgroundFile;

  @override
  void initState() {
    super.initState();
    settingController.fetchSetting().then((_) {
      final data = settingController.setting.value;
      if (data != null) {
        namaController.text = data.namaSekolah;
        npsnController.text = data.npsn ?? '';
        teleponController.text = data.telepon ?? '';
        emailController.text = data.email ?? '';
        websiteController.text = data.website ?? '';
        periodeController.text = data.periode ?? '';
        alamatController.text = data.alamat ?? '';
        kotaController.text = data.city ?? '';
        provinsiController.text = data.province ?? '';
        kecamatanController.text = data.district ?? '';
        kelurahanController.text = data.subdistrict ?? '';
        kodePosController.text = data.kodePos ?? '';
        jamMasukController.text = data.jamMasuk;
        jamPulangController.text = data.jamPulang;
        latitudeController.text = data.latitude;
        longitudeController.text = data.longitude;
        radiusController.text = data.radius;
      }
    });
  }

  Future<void> _pickImage(bool isLogo) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (isLogo) {
          logoFile = File(picked.path);
        } else {
          backgroundFile = File(picked.path);
        }
      });
    }
  }

  void _nextStep() {
    if (_step < 2) {
      setState(() {
        _step++;
      });
    }
  }

  void _prevStep() {
    if (_step > 0) {
      setState(() {
        _step--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Pengaturan Sekolah"),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: IndexedStack(
          index: _step,
          children: [_buildStep1(), _buildStep2(), _buildStep3()],
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return ListView(
      children: [
        const Text(
          "Step 1: Data Sekolah",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _textField(namaController, "Nama Sekolah", Icons.school_outlined),
        _textField(npsnController, "NPSN", Icons.text_fields_outlined),
        _textField(teleponController, "Telepon", Icons.phone_android_outlined),
        _emailField(emailController, "Email", Icons.email_outlined),
        _textField(websiteController, "Website", Icons.android_outlined),
        _textField(periodeController, "Periode", Icons.date_range_outlined),
        const SizedBox(height: 12),
        const Text("Logo Sekolah"),
        GestureDetector(
          onTap: () => _pickImage(true),
          child: logoFile != null
              ? Image.file(logoFile!, height: 100)
              : Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: const Center(child: Text("Pilih Logo")),
                ),
        ),
        const SizedBox(height: 12),
        const Text("Background"),
        GestureDetector(
          onTap: () => _pickImage(false),
          child: backgroundFile != null
              ? Image.file(backgroundFile!, height: 100)
              : Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: const Center(child: Text("Pilih Background")),
                ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _nextStep, child: const Text("Selanjutnya")),
      ],
    );
  }

  Widget _buildStep2() {
    return ListView(
      children: [
        const Text(
          "Step 2: Alamat Sekolah",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _textField(alamatController, "Alamat", Icons.map_outlined),
        _textField(kotaController, "Kota", Icons.location_city_outlined),
        _textField(
          provinsiController,
          "Provinsi",
          Icons.location_city_outlined,
        ),
        _textField(
          kecamatanController,
          "Kecamatan",
          Icons.location_city_outlined,
        ),
        _textField(
          kelurahanController,
          "Kelurahan",
          Icons.location_city_outlined,
        ),
        _textField(kodePosController, "Kode Pos", Icons.location_city_outlined),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: _prevStep,
              child: const Text("Sebelumnya"),
            ),
            ElevatedButton(
              onPressed: _nextStep,
              child: const Text("Selanjutnya"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Obx(() {
      final isLoading = settingController.isLoading.value;
      final error = settingController.errorMessage.value;

      return ListView(
        children: [
          const Text(
            "Step 3: Setting Absen",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _selectField(
            jamMasukController,
            "Jam Masuk",
            Icons.timeline_outlined,
          ),
          _selectField(
            jamPulangController,
            "Jam Pulang",
            Icons.timeline_outlined,
          ),
          _textField(latitudeController, "Latitude", Icons.map_outlined),
          _textField(longitudeController, "Longitude", Icons.map_outlined),
          _textField(radiusController, "Radius (meter)", Icons.map_outlined),
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _prevStep,
                child: const Text("Sebelumnya"),
              ),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        final input = {
                          'namaSekolah': namaController.text,
                          'npsn': npsnController.text,
                          'telepon': teleponController.text,
                          'email': emailController.text,
                          'website': websiteController.text,
                          'periode': periodeController.text,
                          'alamat': alamatController.text,
                          'city': kotaController.text,
                          'province': provinsiController.text,
                          'district': kecamatanController.text,
                          'subdistrict': kelurahanController.text,
                          'kodePos': kodePosController.text,
                          'jamMasuk': jamMasukController.text,
                          'jamPulang': jamPulangController.text,
                          'latitude': latitudeController.text,
                          'longitude': longitudeController.text,
                          'radius': radiusController.text,
                        };

                        // Pastikan id setting ada
                        final id = settingController.setting.value?.id;
                        if (id == null) {
                          Get.snackbar('Error', 'ID setting tidak ditemukan.');
                          return;
                        }

                        await settingController.updateSetting(
                          id: id,
                          input: input,
                          logo: logoFile,
                          background: backgroundFile,
                        );
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Simpan"),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _textField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CTextField(
        title: label,
        icon: icon,
        size: 20,
        hint: '',
        inputType: TextInputType.text,
        controller: controller,
      ),
    );
  }

  Widget _emailField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CTextField(
        title: label,
        icon: icon,
        size: 20,
        hint: '',
        inputType: TextInputType.emailAddress,
        controller: controller,
      ),
    );
  }

  Widget _selectField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CSelectField<String>(
        title: label,
        hint: "Pilih  $label",
        value: controller.text.isNotEmpty ? controller.text : null,
        items: jamList.map((jam) {
          return DropdownMenuItem<String>(value: jam, child: Text(jam));
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              controller.text = value; // 🔁 simpan ke controller
            });
          }
        },
      ),
    );
  }
}
