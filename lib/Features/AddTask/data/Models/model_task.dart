import 'package:hive/hive.dart';
part 'model_task.g.dart';

@HiveType(typeId: 1)
class ModelTask extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String date;
  @HiveField(3)
  int color;
  @HiveField(4)
  bool isCompleted;

  ModelTask({
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    this.isCompleted = false,
  });

  ModelTask copyWith({
    String? title,
    String? description,
    String? date,
    int? color,
    bool? isCompleted,
  }) {
    return ModelTask(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelTask &&
          title == other.title &&
          description == other.description &&
          date == other.date &&
          color == other.color &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode => Object.hash(title, description, date, color, isCompleted);
}
