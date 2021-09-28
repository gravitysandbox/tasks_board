class TaskItem {
  final String id;
  String title;
  String subtitle;
  bool isComplete;

  TaskItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isComplete,
  });

  TaskItem copyWith({
    String? title,
    String? subtitle,
    bool? isComplete,
  }) {
    return TaskItem(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
