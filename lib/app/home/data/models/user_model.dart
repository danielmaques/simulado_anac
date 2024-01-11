class UserModel {
  final String name;
  final String email;
  final String? photoUrl;
  final String uid;
  final int approvedCount;
  final int disapprovedCount;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    this.photoUrl,
    required this.approvedCount,
    required this.disapprovedCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      photoUrl: json['photoUrl'],
      approvedCount: json['approvedCount'],
      disapprovedCount: json['disapprovedCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'approvedCount': approvedCount,
      'disapprovedCount': disapprovedCount,
    };
  }
}
