class GoalClass {
  int id;
  String title;
  int createdAt;
  //DateTime createdAt;

  GoalClass({required this.id, required this.title, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'createdAt': createdAt};
  }
}
