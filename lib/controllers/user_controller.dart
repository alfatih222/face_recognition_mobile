import 'dart:io';

import 'package:facerecognition/graphql/graphql_base.dart';
import 'package:facerecognition/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MeController extends GetxController {
  Rx<Profile?> profile = Rx<Profile?>(null);

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isSuccess = false.obs;

  Future<void> fetchMe() async {
    isLoading.value = true;
    errorMessage.value = '';

    const String query = '''
    query {
     me {
        profile {
          id
          fullname
          nip
          placeOfBirth
          dateOfBirth
          gender
          address
          phone
          profilePhoto
          profilePhotoUrl
          user {
            id
            email
            password
            role_id
            role {
              id
              name
              desc
            }
          }
        }
      }
    }
    ''';

    try {
      final res = await GraphQLBase().query(query);
      print(['sddsccs', res]);
      if (res != null && res['me'] != null && res['me']['profile'] != null) {
        profile.value = Profile.fromJson(res['me']['profile']);
      } else {
        errorMessage.value = 'Gagal mengambil data user';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({
    required String? id,
    required Map<String, dynamic> input,
    File? profilePhoto,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    isSuccess.value = false;

    const String mutation = '''
      mutation updateProfile(\$input: UpdateProfileInput!, \$profilePhoto: ImageFile, \$id: ID) {
        updateProfile(input: \$input, profilePhoto: \$profilePhoto, id: \$id) {
          ...on Profile {
      id
            address
            dateOfBirth
            fullname
            gender
            nip
            phone
            placeOfBirth
            profilePhoto
            profilePhotoUrl
            user{
              password
              role{
              name
              }
            }
    }

    ...on Error{
      message
    }
    ...on InvalidInputError{
      message
    }
        }
      }
    ''';

    http.MultipartFile? profilePhotoMultipart;
    if (profilePhoto != null) {
      profilePhotoMultipart = await http.MultipartFile.fromPath(
        'profilePhoto',
        profilePhoto.path,
        contentType: MediaType('image', 'jpeg'),
      );
    }

    final variables = {
      "id": id,
      "input": input,
      "profilePhoto": profilePhotoMultipart,
    };
    print(['variablessasa', variables]);
    try {
      final result = await GraphQLBase().mutate(mutation, variables: variables);
      print(['ddees', result]);
      if (result != null && result['updateProfile'] != null) {
        isSuccess.value = true;
      } else {
        errorMessage.value = 'Gagal update profile';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
