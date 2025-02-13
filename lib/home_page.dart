import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail_penjualan/index_detail_penjualan.dart';
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
          backgroundColor: const Color.fromARGB(121, 255, 184, 219),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(elevation: 16, child: Container()),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndexPelanggan()));
                        },
                        child: Text('Pelanggan',
                            style: TextStyle(
                                color: Color.fromARGB(121, 234, 93, 163)))),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndexPenjualan()));
                        },
                        child: Text('Penjualan',
                            style: TextStyle(
                                color: Color.fromARGB(121, 234, 93, 163)))),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      IndexDetailPenjualan()));
                        },
                        child: Text('Detail Penjualan',
                            style: TextStyle(
                                color: Color.fromARGB(121, 234, 93, 163)))),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndexProduk()));
                        },
                        child: Text('Produk',
                            style: TextStyle(
                                color: Color.fromARGB(121, 234, 93, 163)))),
                  ],
                ))));
  }
}
