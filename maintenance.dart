import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'motorcycle_model.dart'; // Импортируем модель мотоцикла
import 'maintenance_model.dart'; // Импортируем модель обслуживания

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  late Box<Motorcycle> motorcycleBox; // Хранилище мотоциклов
  late Box<MaintenanceRecord> maintenanceBox; // Хранилище обслуживания

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  void _openBoxes() async {
    motorcycleBox = await Hive.openBox<Motorcycle>('motorcycles');
    maintenanceBox = await Hive.openBox<MaintenanceRecord>('maintenance');
    setState(() {}); // Перезагружаем состояние, когда откроются боксы
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Обслуживание')),
      body: ListView.builder(
        itemCount: motorcycleBox.length,
        itemBuilder: (context, index) {
          final motorcycle = motorcycleBox.getAt(index);
          return Card(
            child: ListTile(
              title: Text(motorcycle!.name),
              subtitle: Text(
                'Дата покупки: ${motorcycle.purchaseDate}, Цена: \$${motorcycle.purchasePrice}',
              ),
              onTap: () {
                _showMaintenanceDialog(motorcycle, index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMotorcycleDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddMotorcycleDialog() {
    final nameController = TextEditingController();
    final purchaseDateController = TextEditingController();
    final purchasePriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Добавить мотоцикл'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Название модели'),
              ),
              TextField(
                controller: purchaseDateController,
                decoration: InputDecoration(labelText: 'Дата покупки'),
              ),
              TextField(
                controller: purchasePriceController,
                decoration: InputDecoration(labelText: 'Цена покупки'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final purchaseDate = purchaseDateController.text;
                final purchasePrice =
                    double.tryParse(purchasePriceController.text) ?? 0.0;

                final motorcycle = Motorcycle(
                  name: name,
                  purchaseDate: purchaseDate,
                  purchasePrice: purchasePrice,
                );

                motorcycleBox.add(motorcycle); // Добавляем мотоцикл в Hive
                Navigator.pop(context);
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _showMaintenanceDialog(Motorcycle motorcycle, int index) {
    final maintenanceDateController = TextEditingController();
    final descriptionController = TextEditingController();
    final costController = TextEditingController();
    final mileageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Записать обслуживание для ${motorcycle.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: maintenanceDateController,
                decoration: InputDecoration(labelText: 'Дата обслуживания'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Описание обслуживания'),
              ),
              TextField(
                controller: costController,
                decoration: InputDecoration(labelText: 'Стоимость'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: mileageController,
                decoration: InputDecoration(labelText: 'Пробег'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final maintenanceDate = maintenanceDateController.text;
                final description = descriptionController.text;
                final cost = double.tryParse(costController.text) ?? 0.0;
                final mileage = int.tryParse(mileageController.text) ?? 0;

                final maintenanceRecord = MaintenanceRecord(
                  maintenanceDate: maintenanceDate,
                  description: description,
                  cost: cost,
                  mileage: mileage,
                );

                maintenanceBox.add(
                  maintenanceRecord,
                ); // Добавляем запись в Hive
                Navigator.pop(context);
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }
}
