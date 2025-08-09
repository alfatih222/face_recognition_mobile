class Setting {
  String id;
  String namaSekolah;
  String? npsn;
  String? periode;
  String? alamat;
  String? city;
  String? province;
  String? district;
  String? subdistrict;
  String? kodePos;
  String jamMasuk;
  String jamPulang;
  String latitude;
  String longitude;
  String radius;
  String? logoSekolah;
  String? background;
  String? email;
  String? telepon;
  String? website;

  Setting({
    required this.id,
    required this.namaSekolah,
    this.npsn,
    this.periode,
    this.alamat,
    this.city,
    this.province,
    this.district,
    this.subdistrict,
    this.kodePos,
    required this.jamMasuk,
    required this.jamPulang,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.logoSekolah,
    this.background,
    this.email,
    this.telepon,
    this.website,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json['id'],
      namaSekolah: json['namaSekolah'],
      npsn: json['npsn'],
      periode: json['periode'],
      alamat: json['alamat'],
      city: json['city'],
      province: json['province'],
      district: json['district'],
      subdistrict: json['subdistrict'],
      kodePos: json['kodePos'],
      jamMasuk: json['jamMasuk'],
      jamPulang: json['jamPulang'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: json['radius'],
      logoSekolah: json['logoSekolah'],
      background: json['background'],
      email: json['email'],
      telepon: json['telepon'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaSekolah': namaSekolah,
      'npsn': npsn,
      'periode': periode,
      'alamat': alamat,
      'city': city,
      'province': province,
      'district': district,
      'subdistrict': subdistrict,
      'kodePos': kodePos,
      'jamMasuk': jamMasuk,
      'jamPulang': jamPulang,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'logoSekolah': logoSekolah,
      'background': background,
      'email': email,
      'telepon': telepon,
      'website': website,
    };
  }
}

// class CityDto {
//   String id;
//   String name;

//   CityDto({required this.id, required this.name});

//   factory CityDto.fromJson(Map<String, dynamic> json) {
//     return CityDto(id: json['id'], name: json['name']);
//   }

//   Map<String, dynamic> toJson() {
//     return {'id': id, 'name': name};
//   }
// }

// class DistrictDto {
//   String id;
//   String name;
//   String? noKec;
//   String? noKab;
//   String? noProp;

//   DistrictDto({
//     required this.id,
//     required this.name,
//     this.noKec,
//     this.noKab,
//     this.noProp,
//   });

//   factory DistrictDto.fromJson(Map<String, dynamic> json) {
//     return DistrictDto(
//       id: json['id'],
//       name: json['name'],
//       noKec: json['no_kec'],
//       noKab: json['no_kab'],
//       noProp: json['no_prop'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'no_kec': noKec,
//       'no_kab': noKab,
//       'no_prop': noProp,
//     };
//   }
// }

// class ProvinceDto {
//   String id;
//   String name;

//   ProvinceDto({required this.id, required this.name});

//   factory ProvinceDto.fromJson(Map<String, dynamic> json) {
//     return ProvinceDto(id: json['id'], name: json['name']);
//   }

//   Map<String, dynamic> toJson() {
//     return {'id': id, 'name': name};
//   }
// }

// class SubdistrictDto {
//   String id;
//   String name;
//   String? noKel;
//   String? noKec;
//   String? noKab;
//   String? noProp;

//   SubdistrictDto({
//     required this.id,
//     required this.name,
//     this.noKel,
//     this.noKec,
//     this.noKab,
//     this.noProp,
//   });

//   factory SubdistrictDto.fromJson(Map<String, dynamic> json) {
//     return SubdistrictDto(
//       id: json['id'],
//       name: json['name'],
//       noKel: json['no_kel'],
//       noKec: json['no_kec'],
//       noKab: json['no_kab'],
//       noProp: json['no_prop'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'no_kel': noKel,
//       'no_kec': noKec,
//       'no_kab': noKab,
//       'no_prop': noProp,
//     };
//   }
// }
