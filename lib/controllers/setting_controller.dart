import 'dart:io';

import 'package:facerecognition/graphql/graphql_base.dart';
import 'package:facerecognition/models/setting_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class SettingController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<Setting?> setting = Rx<Setting?>(null);

  Future<void> fetchSetting() async {
    isLoading.value = true;
    errorMessage.value = '';

    const String query = '''
      query {
        getSetting {
          ...on settingSync {
            id
            alamat
            background
            city
            province
            district
            subdistrict
            email
            jamMasuk
            jamPulang
            kodePos
            logoSekolah
            latitude
            longitude
            namaSekolah
            npsn
            periode
            radius
            telepon
            website
          }
        }
      }
    ''';

    try {
      final res = await GraphQLBase().query(query);
      final data = res?['getSetting'];
      if (data != null) {
        setting.value = Setting.fromJson(data);
      } else {
        errorMessage.value = 'Data setting tidak ditemukan.';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSetting({
    required String id,
    required Map<String, dynamic> input,
    File? logo,
    File? background,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    const String mutation = '''
    mutation updateSetting(\$input: SettingSync!, \$logo: ImageFile, \$background: ImageFile, \$id: String!) {
      updateSetting(input: \$input, logo: \$logo, background: \$background, id: \$id) {
        ...on ResponseSetting {
          nodes {
            id
          }
          message
        }
      }
    }
  ''';

    try {
      // Membuat MultipartFile untuk logo jika ada
      http.MultipartFile? logoMultipart;
      if (logo != null) {
        logoMultipart = await http.MultipartFile.fromPath(
          'logo',
          logo.path,
          contentType: MediaType(
            'image',
            'jpeg',
          ), // sesuaikan jika format berbeda
        );
      }

      // Membuat MultipartFile untuk background jika ada
      http.MultipartFile? backgroundMultipart;
      if (background != null) {
        backgroundMultipart = await http.MultipartFile.fromPath(
          'background',
          background.path,
          contentType: MediaType(
            'image',
            'jpeg',
          ), // sesuaikan jika format berbeda
        );
      }

      // Variabel untuk mutation, sertakan file MultipartFile jika ada
      final variables = {
        'id': id,
        'input': input,
        'logo': logoMultipart,
        'background': backgroundMultipart,
      };

      // Jalankan mutation menggunakan GraphQLBase().mutate yang sudah support upload
      final result = await GraphQLBase().mutate(mutation, variables: variables);

      final data = result?['updateSetting'];
      if (data != null) {
        // Jika sukses, refresh setting dan beri notifikasi
        await fetchSetting();
        Get.snackbar(
          "Success",
          data['message'] ?? 'Setting berhasil diperbarui',
        );
      } else {
        errorMessage.value = 'Gagal update setting.';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
