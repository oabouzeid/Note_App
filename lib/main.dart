import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app2/screens/home_page.dart';
import 'database/app_database.dart';

late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  database = await $FloorAppDatabase
      .databaseBuilder('notes_database.db')
      .build();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}