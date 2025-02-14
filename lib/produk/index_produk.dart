import 'package:flutter/material.dart';
import 'package:flutter_application_1/produk/update_produk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexProduk extends StatefulWidget {
  const IndexProduk({super.key});

  @override
  State<IndexProduk> createState() => _IndexProdukState();
}

class _IndexProdukState extends State<IndexProduk> {
  List<Map<String, dynamic>> produk = [];
  @override
  void initState() {
    super.initState();
    dataProduk();
  }

  Future<void> dataProduk() async {
    try {
      final response = await Supabase.instance.client.from('produk').select();
      setState(() {
        produk = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> hapusData(int id) async {
    try {
      final response = await Supabase.instance.client
          .from('produk')
          .delete()
          .eq('ProdukId', id);
      dataProduk();
    } catch (e) {
      print('Error: $e');
    }
  }

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
            'Data Produk',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: produk.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada data produk',
                      style: TextStyle(color: Color.fromARGB(121, 255, 0, 128)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: produk.length,
                    itemBuilder: (context, index) {
                      final pr = produk[index];
                      return SizedBox(
                        height: 145,
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      pr['NamaProduk'] ?? 'Nama Produk kosong',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      pr['Harga'] ?? 'Harga kosong',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      pr['Stok'] ?? 'Stork kosong',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic),
                                    )
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      );
                    })));
  }
}
