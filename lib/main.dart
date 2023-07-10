import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';

void main() {
  // Overrides the default Http client with custom user agent string.
  // It's likely for web scraping or interacting with web APIs that require a specific user agent.
  HttpOverrides.global = MyHttpOverrides();

  // Entry point for the Flutter application.
  runApp(const MyApp());
}

// Class to override the Http client with custom user agent.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Sets a custom user agent string for the Http client.
    return super.createHttpClient(context)
      ..userAgent =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Builds the widget tree of the app.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a wrapper for Material Design applications.
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFE7626C),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      darkTheme: ThemeData.dark().copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      // HomeScreen is likely defined in another file.
      home: const Scaffold(
        body: LoadingScreen(),
      ),
    );
  }
}

// LoadingScreen is a StatefulWidget that shows a loading screen while data is being fetched.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Fetches data asynchronously and then navigates to the main screen.
    _loadData().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  // Simulates a network request by delaying for 1.5 seconds.
  Future _loadData() async {
    await Future.delayed(
      const Duration(
        milliseconds: 1500,
      ),
    );
    return true;
  }

  // Builds the loading screen widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          // Uses a background image for the loading screen.
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/loading_screen.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

// App is the main widget that wraps the application once data is loaded.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreen(),
    );
  }
}
