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
    http.Response res = await http.get(Uri.parse("https://pixabay.com/api/?key=47290946-f24a532c9cde2b26ed1a38eef&orientation=vertical"));
    interceptor(res);
    Map<String, dynamic> map = jsonDecode(res.body);

    List list = map['hits'];

    return list;
  }

  Future<List<dynamic>> getRestUsers() async {
    http.Response res = await http.get(Uri.parse("https://api-generator.retool.com/oOhR1I/data"));

    return jsonDecode(res.body);
    interceptor(res);
  }

  Future addUser(String name, String email) async {
    Map<String, dynamic> reqPram = {
      "name": name,
      "email": email,
    };

    http.Response res = await http.post(
      Uri.parse("https://api-generator.retool.com/oOhR1I/data"),
      body: jsonEncode(reqPram),
      headers: {"Content-Type": "application/json"},
    );
    interceptor(res);
  }

  Future<bool> deleteUser(num id) async {
    http.Response res = await http.delete(Uri.parse("https://api-generator.retool.com/oOhR1I/data/$id"));
    return res.statusCode == 200;
  }

  Future<List<dynamic>> getCategoryPhotos(String category) async {
    http.Response res = await http.get(Uri.parse("https://pixabay.com/api/?key=47290946-f24a532c9cde2b26ed1a38eef&category=$category"));
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
