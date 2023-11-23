class AppUser {
  String? email;
  String? password;
  String? name;
  String? mobileNo;
  String? age;
  String? location;
  String? gender;
  String? fcmToken;
  String? imageUrl;
  String? createdAt;
  String? id;
  String? dob;
  String? confirmPassword;

  AppUser(
      {this.email,
      this.password,
      this.name,
      this.mobileNo,
      this.age,
      this.location,
      this.gender,
      this.fcmToken,
      this.imageUrl,
      this.createdAt,
      this.id,
      this.dob,
      this.confirmPassword});

  AppUser.fromJson(json, id) {
    this.id = id;
    this.name = json['name'];
    this.email = json['email'];
    this.fcmToken = json['fcm_token'];
    this.mobileNo = json['mobile'];
    this.age = json['age'];
    this.location = json['location'] != null ? json['location'] : '';
    this.gender = json['gender'];
    this.imageUrl = json['image_url'];
    this.createdAt = json['created_at'];
    this.dob = json['dob'];
  }

  toJson() => {
        'email': this.email,
        'fcm_token': this.fcmToken,
        'age': this.age,
        'image_url': this.imageUrl,
        'createdAt': this.createdAt,
        'mobile': this.mobileNo,
        'dob': this.dob,
        'location': this.location,
        'gender': this.gender,
        'name': this.name
      };
}
