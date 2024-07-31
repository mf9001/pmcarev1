// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  int id;
  String mwfid;
  String mwfname;
  String date;
  String serialdate;

  Post({
    required this.id,
    required this.mwfid,
    required this.mwfname,
    required this.date,
    required this.serialdate,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        mwfid: json["mwfid"],
        mwfname: json["mwfname"],
        date: json["date"],
        serialdate: json["serialdate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mwfid": mwfid,
        "mwfname": mwfname,
        "date": date,
        //"${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "serialdate": serialdate,
      };
}
