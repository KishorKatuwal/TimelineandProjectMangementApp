import 'dart:convert';

class EventDataModel {
  final String EventID;
  final String EventName;
  final String EventDate;
  final String EventTime;
  final String Subject;
  final String Description;
  final String EventType;

  EventDataModel({
    required this.EventID,
    required this.EventName,
    required this.EventDate,
    required this.EventTime,
    required this.Subject,
    required this.Description,
    required this.EventType,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'EventID': EventID});
    result.addAll({'EventName': EventName});
    result.addAll({'EventDate': EventDate});
    result.addAll({'EventTime': EventTime});
    result.addAll({'Subject': Subject});
    result.addAll({'Description': Description});
    result.addAll({'EventType': EventType});

    return result;
  }

  factory EventDataModel.fromMap(Map<String, dynamic> map) {
    return EventDataModel(
      EventID: map['_id'] ?? '',
      EventName: map['EventName'] ?? '',
      EventDate: map['EventDate'] ?? '',
      EventTime: map['EventTime'] ?? '',
      Subject: map['Subject'] ?? '',
      Description: map['Description'] ?? '',
      EventType: map['EventType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDataModel.fromJson(String source) =>
      EventDataModel.fromMap(json.decode(source));
}
