import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logo.jpeg'),
            SizedBox(height: 20), // 이미지와 텍스트 사이 간격
            Text('This is Logo'),
          ],
        ),
      ),
    );
  }
}
