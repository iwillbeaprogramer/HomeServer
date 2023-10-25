import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestSession{
  //Property

  final String? uri;

  RequestSession([String? uri])
  : uri = uri ?? "wisixicidi.iptime.org";


  Future<Map<String,dynamic>> get(List<String> paths,Map<String,String> querys)async{
    List<String> querysList = [];
    querys.forEach((key, value) {querysList.add("$key=$value");});
    var url = Uri.parse("$uri/${paths.join('/')}?${querysList.join('&')}");
    var response = await http.get(url);
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<Map<String,dynamic>> post(List<String> paths,Map<String,String> querys,Map<String,String>? headers,Map body)async{
    List<String> querysList = [];
    querys.forEach((key, value) {querysList.add("$key=$value");});
    var url = Uri.parse("$uri/${paths.join('/')}?${querysList.join('&')}");
    var response = (headers==null)?(await http.post(url,body: body)):(await http.post(url,body: body,headers: headers));
    return json.decode(utf8.decode(response.bodyBytes));
  }
}