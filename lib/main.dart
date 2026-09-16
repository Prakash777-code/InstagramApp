import 'package:flutter/material.dart';
import 'package:instagram/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

//& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" connect 172.20.10.13:5555

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

