import 'package:logger/logger.dart';
import 'package:shelf/_core/constants/http.dart';

class User {
  int id;
  String email;
  String nickName;
  bool status;
  String avatar;
  DateTime? createdAt;
  String? subPeriod;
  String? nextPaymentDate;

  User({
    required this.id,
    required this.email,
    required this.nickName,
    required this.status,
    required this.avatar,
    this.createdAt,
    this.subPeriod,
    this.nextPaymentDate,
  });

  User copyWith({
    int? id,
    String? email,
    String? nickName,
    bool? status,
    String? avatar,
    DateTime? createdAt,
    String? subPeriod,
    String? nextPaymentDate,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      nickName: nickName ?? this.nickName,
      status: status ?? this.status,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      subPeriod: subPeriod ?? this.subPeriod,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
    );
  }


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      nickName: json["nickName"],
      status: json["status"],
      avatar: json["avatar"],
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      subPeriod: json["subPeriod"],
      nextPaymentDate: json["nextPaymentDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "nickName": nickName,
      "status": status,
      "createdAt": createdAt?.toIso8601String(),
      "subPeriod": subPeriod,
      "nextPaymentDate": nextPaymentDate,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, nickName: $nickName,  status: $status, createdAt: $createdAt}';
  }


}
