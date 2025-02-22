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
  final user = TextEditingController();
  final pass = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;

  final List<Map<String, String>> dummyUser = [
    {"Username": "Nadya", "Password": "111"},
    {"Username": "Yohana", "Password": "222"},
    {"Username": "Putri", "Password": "333"}
  ];

  Future<void> login() async {
    final username = user.text;
    final password = pass.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Input tidak boleh kosong')));
      return;
    }

    final validDummyUser = dummyUser.any(
      (u) => u["Username"] == user && u["Password"] == pass,
    );

    if (validDummyUser) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return;
    }

    try {
      final response = await supabase
          .from('user')
          .select('Username, Password')
          .eq('Username', username)
          .maybeSingle();

      if (response != null && response['Password'] == password) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Input kosong salah satu')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('username/password salah')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Color.fromARGB(121, 255, 0, 128)),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Toko Permen NyamNyamm',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Login Dulu Ya!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: user,
                decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: pass,
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login',
                    style: TextStyle(
                        color: Color.fromARGB(121, 255, 0, 128), fontSize: 15)),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
