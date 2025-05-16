import 'package:hive/hive.dart';

part 'motorcycle_model.g.dart'; // Автоматически сгенерированный файл Hive

@HiveType(typeId: 1)
class Motorcycle {
  @HiveField(0)
  final String name; // Название модели мотоцикла

  @HiveField(1)
  final String purchaseDate; // Дата покупки

  @HiveField(2)
  final double purchasePrice; // Цена покупки

  Motorcycle({
    required this.name,
    required this.purchaseDate,
    required this.purchasePrice,
  });
}
