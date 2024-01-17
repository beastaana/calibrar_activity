class RedditFields {
  
  static final List<String> values = [
    id, title, subtitle, date, isDeleted
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String date = 'date';
  static const String isDeleted = 'false';
}
  
class RedditModel {

  final int? id;
  final String title;
  final String subtitle;
  final String date;
  final bool isDeleted;

  const RedditModel({
    this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isDeleted,
  });

  RedditModel copy({
    int? id,
    String? title,
    String? subtitle,
    String? date,
    bool? isDeleted,
  }) {
    return RedditModel(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        date: date ?? this.date,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  }

  static RedditModel fromJson(Map<String, Object?> json) => RedditModel(
    id: json[RedditFields.id] as int?,
    title: json[RedditFields.title] as String,
    subtitle: json[RedditFields.subtitle] as String,
    date: json[RedditFields.date] as String,
    isDeleted: json[RedditFields.isDeleted] as bool,
  );

  Map<String, Object?> toJson() => {
    RedditFields.id: id,
    RedditFields.title: title,
    RedditFields.subtitle: subtitle,
    RedditFields.date: date,
    RedditFields.isDeleted: isDeleted,
  };
}
