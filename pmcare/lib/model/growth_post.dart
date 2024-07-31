// To parse this JSON data, do
//
//     final feedingPost = feedingPostFromJson(jsonString);

import 'dart:convert';

List<Map<String, GrowthPost>> feedingPostFromJson(String str) =>
    List<Map<String, GrowthPost>>.from(json.decode(str).map((x) => Map.from(x)
        .map((k, v) =>
            MapEntry<String, GrowthPost>(k, GrowthPost.fromJson(v)))));

String feedingPostToJson(List<Map<String, GrowthPost>> data) =>
    json.encode(List<dynamic>.from(data.map((x) =>
        Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))));

class GrowthPost {
  String note;
  String parameter;
  String? pntid;
  String stime;
  String amount;
  String unit;
  String docid;
  String cwhoprec;

  GrowthPost({
    required this.note,
    required this.parameter,
    String? this.pntid,
    required this.stime,
    required this.amount,
    required this.unit,
    required this.docid,
    required this.cwhoprec,
  });

  factory GrowthPost.fromJson(Map<String, dynamic> json) => GrowthPost(
        note: json["note"],
        parameter: json["parameter"],
        pntid: json["pntid"],
        stime: json["stime"],
        amount: json["amount"],
        unit: json["unit"],
        docid: json["docid"],
        cwhoprec: json["cwhoprec"],
      );

  Map<String, dynamic> toJson() => {
        "note": note,
        "parameter": parameter,
        "pntid": pntid,
        "amount": amount,
        "unit": unit,
        "docid": docid,
        "cwhoprec": cwhoprec,
      };
}
