import 'package:http/http.dart' as http;
import 'dart:async';

class ClockApi {
  static Future getUserClock(int userId) {
//    return http.get('http://10.0.2.2:4000/api/clocks/$userId');
    return http.get('https://jsonplaceholder.typicode.com/posts');
  }
  static Future createWorkingTime(int userId, DateTime time, bool status) {
    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{ "clock": { "time": "time", "status": "status" } }';
    String json = '{"title": "$status", "body": "$time", "userId": $userId}';
    print("json sent: $json");
    return http.post('https://jsonplaceholder.typicode.com/posts/$userId', headers: headers, body: json);
  }

}
