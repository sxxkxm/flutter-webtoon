import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadData().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    });
  }

  Future _loadData() async {
    // 여기서 비동기적으로 데이터를 불러옵니다.
    // 예를 들어, 서버에서 데이터를 가져오는 작업이 있을 수 있습니다.
    await Future.delayed(const Duration(seconds: 5)); // 5초 동안 대기하는 예시
    // 데이터가 로드되면, Future가 완료됩니다.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // 로딩 인디케이터 표시
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      body: const Center(child: Text("Welcome to Main Page!")),
    );
  }
}
