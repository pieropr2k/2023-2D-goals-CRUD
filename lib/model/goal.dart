class GoalClass {
  int id;
  String title;

  GoalClass({required this.id, required this.title});

  DateTime get createdAt {
    return DateTime.fromMillisecondsSinceEpoch(id);
  }

  GoalClass.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'createdAt': createdAt.toIso8601String()};
  }
}
