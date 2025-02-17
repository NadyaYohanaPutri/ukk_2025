import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail_penjualan/index_detail_penjualan.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pelanggan/index_pelanggan.dart';
import 'package:flutter_application_1/penjualan/index_penjualan.dart';
import 'package:flutter_application_1/produk/index_produk.dart';
import 'package:flutter_application_1/user/index_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const IndexDetailPenjualan(),
    const IndexProduk(),
    const IndexPenjualan(),
    const IndexPelanggan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(121, 255, 0, 128),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Toko Permen NyamNyamm',
            style: TextStyle(color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(121, 255, 0, 128)),
              child: ListTile(
                leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
                title: const Text('Pengaturan',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.people,
                  color: Color.fromARGB(121, 255, 0, 128)),
              title: const Text('User',
                  style: TextStyle(color: Color.fromARGB(121, 255, 0, 128))),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const IndexUser()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout,
                  color: Color.fromARGB(121, 255, 0, 128)),
              title: const Text('Logout',
                  style: TextStyle(color: Color.fromARGB(121, 255, 0, 128))),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(121, 255, 0, 128),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Detail Penjualan'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Produk'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Penjualan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt), label: 'Pelanggan'),
        ],
      ),
    );
  }
}
