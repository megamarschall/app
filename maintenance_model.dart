import 'package:hive/hive.dart';

part 'maintenance_model.g.dart'; // этот файл будет создан автоматически

@HiveType(typeId: 2)
class MaintenanceRecord extends HiveObject {
  @HiveField(0)
  final String maintenanceDate;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double cost;

  @HiveField(3)
  final int mileage;

  MaintenanceRecord({
    required this.maintenanceDate,
    required this.description,
    required this.cost,
    required this.mileage,
  });
}
