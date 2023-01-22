import 'dart:convert';

class EventModel {
  final String title;
  final String description;
  final String name;


  EventModel({
    required this.title,
    required this.description,
    required this.name,

  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'name': name});


    return result;
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      name: map['name'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));
}
