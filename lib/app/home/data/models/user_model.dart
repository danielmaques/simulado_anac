class UserModel {
  final String name;
  final String email;
  final String? photoUrl;
  final String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
    };
  }
}
