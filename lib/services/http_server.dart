import 'dart:convert';

import 'package:http/http.dart';
import 'package:pattern_setstate/models/post_model.dart';

class Rest_APi {
  static String BASE = "jsonplaceholder.typicode.com";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  /* Http Apis */

  static String API_GET = "/posts";
  static String API_CREATE = "/posts";
  static String API_UPDATE = "/posts/"; //{id}
  static String API_DELETE = "/posts/"; //{id}

  /* Http Requests */

  static Future<String> GET_string(String api) async {
    var uri = Uri.https(BASE, api, paramsEmpty()); // http or https
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return "";
  }

  static Future<List<Post>> GET_parsed_list(String api) async {
    var uri = Uri.https(BASE, api, paramsEmpty()); // http or https
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return List<Post>.from(
          jsonDecode(response.body).map((e) => Post.fromJson(e)));
    }
    return [];
  }

  static Future<String> POST(String api, Map<String, String> params) async {
    print(params.toString());
    var uri = Uri.https(BASE, api); // http or https
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Create \n');
      print("response body = ${response.body}");
      print("status code = ${response.statusCode}");
      print('\n');
      return response.body;
    }
    return "";
  }

  static Future<String> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api); // http or https
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200) {
      print('Updated \n');
      print("response body = ${response.body}");
      print("status code = ${response.statusCode}");
      print('\n');
      return response.body;
    }
    return "";
  }

  static Future<String> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params); // http or https
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      print('Deleted \n');
      print("response body = ${response.body}");
      print("status code = ${response.statusCode}");
      print('\n');
      return response.body;
    }
    return "";
  }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }
}
