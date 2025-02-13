import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  Supabase.initialize(
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx4ZW13d3F6ZWJ1dXB0c2FhaXdkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MDkzNjYsImV4cCI6MjA1NDk4NTM2Nn0.cdWDfO4Tili2Zk4UstiMiqYSh4C0IDK1FoqgAlkVaUI",
      url: "https://lxemwwqzebuuptsaaiwd.supabase.co");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(
        title: "",
      ),
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
          backgroundColor: const Color.fromARGB(121, 255, 184, 219),
        ),
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(121, 180, 231, 235)),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login Dulu Ya!',
                    style: TextStyle(
                        color: Color.fromARGB(121, 234, 93, 163),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(121, 234, 93, 163),
                            fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(121, 234, 93, 163),
                            fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: const Text(
                      'Login',
                      style:
                          TextStyle(color: Color.fromARGB(121, 234, 93, 163)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
