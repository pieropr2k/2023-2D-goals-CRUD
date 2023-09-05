class GoalClass {
  int id;
  String title;

  GoalClass({required this.id, required this.title});

  DateTime get createdAt {
    return DateTime.fromMillisecondsSinceEpoch(id);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'createdAt': createdAt};
  }
}
