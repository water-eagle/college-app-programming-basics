import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: '교재 실습하기'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: createS3()),
    );
  }

  Widget createS1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(color: Colors.red, width: 100, height: 40),
        const SizedBox(height: 10),
        Container(color: Colors.blue, width: 100, height: 40),
      ],
    );
  }

  Widget createS2() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(color: Colors.amber),
    );
  }

  // 4.4.7 ListView 가로 스크롤 만들기 - 186쪽
  Widget createS3() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        50,
        (index) => Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.all(5),
          color: Colors.green.withAlpha((index + 1) * 25),
          child: Center(child: Text(index.toString())),
        ),
      ),
    );
  }
}
