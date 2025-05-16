import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Для карты
import 'note_model.dart'; // Модель для заметок
import 'notes.dart'; // Вкладка Заметки
import 'profile.dart'; // Вкладка Профиль
import 'maintenance.dart'; // Вкладка Обслуживание
import 'map.dart'; // Вкладка Карта

void main() async {
  // Инициализация Hive
  await Hive.initFlutter();
  await Hive.openBox<Note>('notes'); // Открытие Hive Box для заметок
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Моё приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Индекс выбранной вкладки

  // Список страниц, соответствующих вкладкам
  final List<Widget> _pages = [
    ProfilePage(), // Профиль
    MapPage(), // Карта
    MaintenancePage(), // Обслуживание
    NotesPage(), // Заметки
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем индекс выбранной вкладки
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Моё приложение')), // Заголовок приложения
      body: _pages[_selectedIndex], // Отображение выбранной страницы
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Текущая вкладка
        onTap: _onItemTapped, // Обработчик нажатия на вкладку
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Карта'),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Обслуживание',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Заметки'),
        ],
        selectedItemColor: Colors.blue, // Цвет для активной вкладки
        unselectedItemColor: Colors.grey, // Цвет для неактивных вкладок
        backgroundColor: Colors.white, // Цвет фона
      ),
    );
  }
}
