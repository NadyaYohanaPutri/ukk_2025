import 'package:flutter/material.dart';
import 'package:flutter_application_1/produk/index_produk.dart';

class InsertProduk extends StatefulWidget {
  const InsertProduk({super.key});

  @override
  State<InsertProduk> createState() => _InsertProdukState();
}

class _InsertProdukState extends State<InsertProduk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(121, 255, 0, 128),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Tambah Data Produk',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login Dulu Ya!',
                    style: TextStyle(
                        color: Color.fromARGB(121, 255, 0, 128),
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
                            color: Color.fromARGB(121, 255, 0, 128),
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
                            color: Color.fromARGB(121, 255, 0, 128),
                            fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndexProduk()));
                    },
                    child: const Text('Simpan',
                        style: TextStyle(
                            color: Color.fromARGB(121, 255, 0, 128),
                            fontSize: 15)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
