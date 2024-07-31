import 'package:dio/dio.dart';

class WebService {
  final Dio dio = Dio();

  Future<dynamic> getHTTP(String apiUrl, String u, String p) async {
    String url = "$apiUrl/$u/$p";
    print(url);
    try {
      final response = await dio.get(url);
      //print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
/*
  Future<List<SchData>?> getEntries(String apiUrl, String a) async {
    String url = "$apiUrl/$a";
    print(url);
    try {
      final response = await dio.get(url);
      print(response.data);
      return schDataFromJson(response.data);
    } catch (e) {
      print(e);
    }
  }*/
}
