class TaskClass {
  int id;
  int? orderIndex;
  String title;
  String content;
  int diaryId;

  TaskClass(
      {required this.id,
      this.orderIndex,
      required this.title,
      required this.content,
      required this.diaryId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderIndex': orderIndex,
      'title': title,
      'content': content,
      'diaryId': diaryId
    };
  }
}
