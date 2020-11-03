import 'package:http/http.dart' as http;
import 'dart:async';

class WorkingTimeApi {
  static Future getUserWorkingTimes(int userId) {
//    return http.get('http://10.0.2.2:4000/api/workingtimes/$userId');
    return http.get('https://jsonplaceholder.typicode.com/posts/$userId');
  }
  static Future createUser(String username, String password, String email) {
    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{ "user": { "username": "$username", "password": "$password", "email": "$email" } }';
    String json = '{"title": "$username", "body": "$password", "userId": 1}';
    print("json sent: $json");
    return http.post('https://jsonplaceholder.typicode.com/posts', headers: headers, body: json);
  }
}
