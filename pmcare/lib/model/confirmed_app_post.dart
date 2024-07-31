// To parse this JSON data, do
//
//     final confirmedAppPost = confirmedAppPostFromJson(jsonString);

import 'dart:convert';

ConfirmedAppPost confirmedAppPostFromJson(String str) =>
    ConfirmedAppPost.fromJson(json.decode(str));

String confirmedAppPostToJson(ConfirmedAppPost data) =>
    json.encode(data.toJson());

class ConfirmedAppPost {
  String mwfid;
  String slotid;
  String status;
  String day;
  String uniqid;
  String email;
  String role;
  String phone;
  String name;

  ConfirmedAppPost({
    required this.mwfid,
    required this.slotid,
    required this.status,
    required this.day,
    required this.uniqid,
    required this.email,
    required this.role,
    required this.phone,
    required this.name,
  });

  factory ConfirmedAppPost.fromJson(Map<String, dynamic> json) =>
      ConfirmedAppPost(
        mwfid: json["mwfid"],
        slotid: json["slotid"],
        status: json["status"],
        day: json["day"],
        uniqid: json["uniqid"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mwfid": mwfid,
        "slotid": slotid,
        "status": status,
        "day": day,
        "uniqid": uniqid,
        "email": email,
        "role": role,
        "phone": phone,
        "name": name,
      };
}
