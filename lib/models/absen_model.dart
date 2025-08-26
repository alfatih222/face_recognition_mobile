import 'package:facerecognition/models/user_model.dart';

class Attendance {
  String id;
  String userId;
  String date;
  String latitude;
  String longitude;
  String type;
  String? checkIn;
  String? checkOut;
  User? user;

  Attendance({
    required this.id,
    required this.userId,
    required this.date,
    required this.latitude,
    required this.longitude,
    this.checkIn,
    this.checkOut,
    required this.type,
    this.user,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      latitude: json['latitude'],
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
      longitude: json['longitude'],
      type: json['type'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'user_id': userId,
      'date': date,
      'latitude': latitude,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'longitude': longitude,
      'type': type,
    };

    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}
