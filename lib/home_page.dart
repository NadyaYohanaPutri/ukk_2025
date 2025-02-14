import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail_penjualan/index_detail_penjualan.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pelanggan/index_pelanggan.dart';
import 'package:flutter_application_1/penjualan/index_penjualan.dart';
import 'package:flutter_application_1/produk/index_produk.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(121, 255, 0, 128),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(121, 255, 0, 128)),
                  child: ListTile(
                    leading: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Pengaturan',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Color.fromARGB(121, 255, 0, 128),
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Color.fromARGB(121, 255, 0, 128), fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                )
              ],
            ),
          ),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const IndexPelanggan()));
                        },
                        child: const Text('Pelanggan',
                            style: TextStyle(
                                color: Color.fromARGB(121, 255, 0, 128)))),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const IndexPenjualan()));
                        },
                        child: const Text('Penjualan',
                            style: TextStyle(
                                color: Color.fromARGB(121, 255, 0, 128)))),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const IndexDetailPenjualan()));
                        },
                        child: const Text('Detail Penjualan',
                            style: TextStyle(
                                color: Color.fromARGB(121, 255, 0, 128)))),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const IndexProduk()));
                        },
                        child: const Text('Produk',
                            style: TextStyle(
                                color: Color.fromARGB(121, 255, 0, 128)))),
                  ],
                ))));
  }
}
