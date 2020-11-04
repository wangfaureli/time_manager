import 'package:time_manager/routes/clock_page.dart';

class Clock {
  final int id;
  final DateTime time;
  final bool status;
  final int userId;

  Clock({this.id, this.status, this.time, this.userId});

  factory Clock.fromJson(Map<String, dynamic> json) {
    return Clock(
      id: json['id'],
      userId: json['userId'],
      time: json['time'],
      status: json['status'],
    );
  }
}