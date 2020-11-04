import 'package:http/http.dart' as http;
import 'dart:async';

class WorkingTimeApi {
  static Future getUserWorkingTimes(int userId) {
//    return http.get('http://10.0.2.2:4000/api/workingtimes/$userId');
    return http.get('https://jsonplaceholder.typicode.com/posts');
  }
  static Future getUserWorkingTime(int userId, int workingTimeId) {
    Map<String, String> headers = {"Content-type": "application/json"};
    return http.get('https://jsonplaceholder.typicode.com/posts/$workingTimeId', headers: headers);
  }
  static Future createWorkingTime(int userId, DateTime start, DateTime end) {
    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{ "working_time": { "start": "start", "end": "end" } }';
    String json = '{"title": "$start", "body": "$end", "userId": $userId}';
    print("json sent: $json");
    return http.post('https://jsonplaceholder.typicode.com/posts/$userId', headers: headers, body: json);
  }
  static Future updateWorkingTime(int userId, int workingTimeId, DateTime start, DateTime end) {
    Map<String, String> headers = {"Content-type": "application/json"};
//    String json = '{ "working_time": { "start": "$start", "end": "$end" } }';
    String json = '{"title": "$start", "body": "$end", "userId": $userId}';
    print("json sent: $json");
    return http.put('https://jsonplaceholder.typicode.com/posts/$workingTimeId', headers: headers, body: json);
  }
  static Future deleteWorkingTime(int workingTimeId) {
    Map<String, String> headers = {"Content-type": "application/json"};
    print("Working time to delete: $workingTimeId");
    return http.delete('https://jsonplaceholder.typicode.com/posts/$workingTimeId', headers: headers);
  }
}

