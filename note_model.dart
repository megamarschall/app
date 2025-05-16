import 'package:hive/hive.dart';

part 'note_model.g.dart'; // Это будет автоматически сгенерированное расширение Hive

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  Note({required this.title, required this.content});
}
