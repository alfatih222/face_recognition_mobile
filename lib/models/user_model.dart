class User {
  String? id;
  String? email;
  String? username;
  String? password;
  String? roleId;
  Role? role; // tambahan properti role

  User({
    this.id,
    this.email,
    this.username,
    this.password,
    this.roleId,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    roleId = json['role_id'];
    if (json['role'] != null) {
      role = Role.fromJson(json['role']);
    }
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      roleId: map['role_id'] as String,
      role: map['role'] != null ? Role.fromMap(map['role']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    data['role_id'] = roleId;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Profile {
  String? id;
  String? fullname;
  String? nip;
  String? placeOfBirth;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? phone;
  String? profilePhoto;
  String? profilePhotoUrl;
  User? user;

  Profile({
    this.id,
    this.fullname,
    this.nip,
    this.placeOfBirth,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.phone,
    this.profilePhoto,
    this.profilePhotoUrl,
    this.user,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    nip = json['nip'];
    placeOfBirth = json['placeOfBirth'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
    profilePhoto = json['profilePhoto'];
    profilePhotoUrl = json['profilePhotoUrl'];
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      fullname: map['fullname'] as String,
      nip: map['nip'] as String,
      placeOfBirth: map['placeOfBirth'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      profilePhoto: map['profilePhoto'] as String,
      profilePhotoUrl: map['profilePhotoUrl'] as String,
      user: map['user'] != null ? User.fromMap(map['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['nip'] = nip;
    data['placeOfBirth'] = placeOfBirth;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['address'] = address;
    data['phone'] = phone;
    data['profilePhoto'] = profilePhoto;
    data['profilePhotoUrl'] = profilePhotoUrl;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Role {
  String? id;
  String? name;
  String? desc;

  Role({this.id, this.name, this.desc});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'] as String,
      name: map['name'] as String,
      desc: map['desc'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    return data;
  }
}
