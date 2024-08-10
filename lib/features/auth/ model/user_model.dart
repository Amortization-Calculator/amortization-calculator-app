class UserModel {
  final String userName;
  final String token;
  final String gender;
  final String expireDate;

  UserModel({
    required this.userName,
    required this.token,
    required this.gender,
    required this.expireDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      token: json['token'],
      gender: json['gender'],
      expireDate: json['expireDate'],
    );
  }
}