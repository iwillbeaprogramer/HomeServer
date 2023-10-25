import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class CustomState extends GetxController {
  GetStorage getStorage = GetStorage();

  Future<List<dynamic>> getCartoonList() async {
    var url = Uri.parse("http://127.0.0.1:8000/cartoon");
    String token = getStorage.read("access_token") ?? "";
    Map<String, String> headers = {
      "Content-Type":"application/json",
      "Accept":"application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url,headers: headers);
    var result = json.decode(utf8.decode(response.bodyBytes));
    return result;
  }

  Map<String,String> getHeaders(){
    String token = getStorage.read("access_token") ?? "";
    Map<String, String> headers = {
      "Content-Type":"application/json",
      "Accept":"application/json",
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  getContents(String title)async{
    var url = Uri.parse("http://127.0.0.1:8000/cartoon/$title/contents");
    String token = getStorage.read("access_token") ?? "";
    Map<String, String> headers = {
      "Content-Type":"application/json",
      "Accept":"application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url,headers: headers);
    var result = json.decode(utf8.decode(response.bodyBytes));
    return result;
  }
}