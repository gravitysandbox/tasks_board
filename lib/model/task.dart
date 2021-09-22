class Task {
  final String id;
  String title;
  String subtitle;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isComplete,
  });

  Task copyWith({
    String? title,
    String? subtitle,
    bool? isComplete,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
