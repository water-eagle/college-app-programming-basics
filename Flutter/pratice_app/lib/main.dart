// 9주차
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _opacity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(child: createS4()),
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

  // 4.4.? PageView 만들기 -
  Widget createS4() {
    return PageView(
      children: [
        Container(
          color: Colors.red,
          child: const Center(
            child: Text(
              "page 1",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          child: const Center(
            child: Text(
              "page 2",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: const Center(
            child: Text(
              "page 3",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
        Container(
          color: Colors.amber,
          child: const Center(
            child: Text(
              "page 4",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  /*
  Widget createS5() {
    return Column(
      children: [
        Expanded(child: TabBarView(controller: _tabController,
        children: [
          Container(
            color: Colors.blue,
            child: Center(child: Text('메뉴1 페이지'),),
          ),
          Container(
            color: Colors.blue,
            child: Center(child: Text('메뉴2 페이지'),),
          ),
          Container(
            color: Colors.blue,
            child: Center(child: Text('메뉴3 페이지'),),
          )
        ],
        )
      )
      ],
    );
  }
  */

  // 4.5.3 AnimatedContainer - 216쪽
  Widget createS6() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          width: _opacity ? 100 : 150,
          height: _opacity ? 100 : 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _opacity ? Colors.red : Colors.blue,
          ),
          onEnd: () {
            print('어쩌고저쩌고');
          },
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _opacity = !_opacity;
              });
            },
            child: const Text('변경하기'),
          ),
        ),
      ],
    );
  }
}
