import 'package:facerecognition/models/user_model.dart';

class Attendance {
  String id;
  String userId;
  String date;
  String lat;
  String lng;
  String type;
  String? checkIn;
  String? checkOut;
  User? user;

  Attendance({
    required this.id,
    required this.userId,
    required this.date,
    required this.lat,
    required this.lng,
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
      lat: json['lat'],
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
      lng: json['lng'],
      type: json['type'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'user_id': userId,
      'date': date,
      'lat': lat,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'lng': lng,
      'type': type,
    };

    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}
