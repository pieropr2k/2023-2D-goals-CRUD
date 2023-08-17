class DiaryClass {
  int id;
  String title;

  DiaryClass({required this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
