import 'package:logger/logger.dart';

class User {
  int id;
  String email;
  String nickName;
  bool status;
  String avatar;
  DateTime? createdAt;

  User({
    required this.id,
    required this.email,
    required this.nickName,
    required this.status,
    required this.avatar,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    Logger().d(" json 테스트 👉👉👉👉👉 $json");
    return User(
      id: int.parse(json["id"]),
      email: json["email"],
      nickName: json["nickName"],
      status: json["status"],
      avatar: json["avatar"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "nickName": nickName,
      "status": status,
      "createdAt": createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, nickName: $nickName,  status: $status, createdAt: $createdAt}';
  }
}
