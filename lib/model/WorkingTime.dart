class WorkingTime {
  final int id;
  final DateTime start;
  final DateTime end;
  final int userId;

  WorkingTime({this.id, this.start, this.end, this.userId});

  factory WorkingTime.fromJson(Map<String, dynamic> json) {
    return WorkingTime(
      id: json['id'],
      userId: json['userId'],
      start: json['start'],
      end: json['end'],
    );
  }
}