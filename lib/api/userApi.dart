import 'package:http/http.dart' as http;
import 'dart:async';

class UserApi {
  static Future createUser(String username, String password, String email) {
    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{ "user": { "username": "$username", "password": "$password", "email": "$email" } }';
    String json = '{"title": "$username", "body": "$password", "userId": 1}';
    print("json sent: $json");
    return http.post('https://jsonplaceholder.typicode.com/posts', headers: headers, body: json);
  }

  static Future login(String username, String password) {
    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{ "user": { "username": "$username", "password": "$password" } }';
    String json = '{"title": "$username", "body": "$password", "userId": 1}';
    print("json sent: $json");
    return http.post('https://jsonplaceholder.typicode.com/posts', headers: headers, body: json);
  }
}
