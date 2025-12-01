import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';

int count = 0;

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진과 위젯 간의 연결을 보장

  runApp(const MyApp());
}

// app.dart 파일과 연동
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '당근마켓 클론 코딩',
      initialRoute: '/',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xff212123),
          titleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      getPages: [GetPage(name: '/', page: () => const App())],
    );
  }
}
