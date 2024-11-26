import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  static ApiHelper obj = ApiHelper._();

  ApiHelper._() {}

  Future<List<dynamic>> getUserLit() async {
    http.Response userResponse = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    interceptor(userResponse);

    List list = jsonDecode(userResponse.body);
    return list;
  }

  Future<List<dynamic>> getPhotos() async {
    http.Response res = await http.get(Uri.parse("https://pixabay.com/api/?key=47290946-f24a532c9cde2b26ed1a38eef"));
    interceptor(res);
    Map<String, dynamic> map = jsonDecode(res.body);

    List list = map['hits'];

    return list;
  }

  void interceptor(http.Response response) {
    print("user===> ${response.statusCode}");
    print("user===> ${response.body}");
  }
}
