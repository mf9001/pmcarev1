// To parse this JSON data, do
//
//     final feedingPost = feedingPostFromJson(jsonString);

import 'dart:convert';

List<Map<String, FeedingPost>> feedingPostFromJson(String str) =>
    List<Map<String, FeedingPost>>.from(json.decode(str).map((x) => Map.from(x)
        .map((k, v) =>
            MapEntry<String, FeedingPost>(k, FeedingPost.fromJson(v)))));

String feedingPostToJson(List<Map<String, FeedingPost>> data) =>
    json.encode(List<dynamic>.from(data.map((x) =>
        Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))));

class FeedingPost {
  String bside;
  String detils;
  String duration;
  String? etime;
  String feedtype;
  String? pntid;
  String stime;
  String amount;
  String unit;

  FeedingPost({
    required this.bside,
    required this.detils,
    required this.duration,
    this.etime,
    required this.feedtype,
    this.pntid,
    required this.stime,
    required this.amount,
    required this.unit,
  });

  factory FeedingPost.fromJson(Map<String, dynamic> json) => FeedingPost(
        bside: json["bside"],
        detils: json["detils"],
        etime: json["etime"],
        duration: json["duration"],
        feedtype: json["feedtype"],
        pntid: json["pntid"],
        stime: json["stime"],
        amount: json["amount"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "bside": bside,
        "detils": detils,
        "duration": duration,
        "etime": etime,
        "feedtype": feedtype,
        "pntid": pntid,
        "stime": etime,
        "amount": amount,
        "unit": unit,
      };
}
