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
            Image.asset('./assets/images/logo_flock.jpeg'),
            /*SizedBox(height: 20), // 이미지와 텍스트 사이 간격
            Text(
              'This is Logo',
              style: TextStyle(
                fontSize: 24, // 글꼴 크기 (기본 단위: 픽셀)
                fontWeight: FontWeight.bold, // 굵기 (bold, normal 등)
                color: Colors.blue, // 색상
                fontStyle: FontStyle.italic, // 기울임 (선택 사항)
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
