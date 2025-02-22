import 'package:flutter/material.dart';
import 'package:flutter_application_1/produk/insert_produk.dart';
import 'package:flutter_application_1/produk/pesan_produk.dart';
import 'package:flutter_application_1/produk/update_produk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexProduk extends StatefulWidget {
  const IndexProduk({super.key});

  @override
  State<IndexProduk> createState() => _IndexProdukState();
}

class _IndexProdukState extends State<IndexProduk> {
  final supabase = Supabase.instance.client;
  final TextEditingController cari = TextEditingController();
  List<Map<String, dynamic>> produkList = [];
  List<Map<String, dynamic>> mencariProduk = [];

  @override
  void initState() {
    super.initState();
    ambilProduk();
    cari.addListener(pencarianProduk);
  }

  Future<void> ambilProduk() async {
    try {
      final data = await supabase.from('produk').select();
      setState(() {
        produkList = List<Map<String, dynamic>>.from(data);
        mencariProduk = produkList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // Digunakan untuk melakukan pencarian produk berdasarkan input pengguna di Search Bar
  void pencarianProduk() {
    setState(() {
      mencariProduk = produkList
          .where((produk) => produk['NamaProduk']
              .toLowerCase()
              .contains(cari.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> hapusProduk(int id) async {
    await supabase.from('produk').delete().eq('ProdukID', id);
    ambilProduk(); // Refresh data setelah menghapus
  }

  void konfirmasiHapus(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Produk'),
        content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          TextButton(
            onPressed: () {
              hapusProduk(id);
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: cari,
              decoration: InputDecoration(
                labelText: "Cari Produk...",
                labelStyle:
                    const TextStyle(color: Color.fromARGB(121, 255, 0, 128)),
                prefixIcon: const Icon(Icons.search,
                    color: Color.fromARGB(121, 255, 0, 128)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: mencariProduk.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak Ada Data Produk',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(121, 255, 0, 128)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: mencariProduk.length,
                    itemBuilder: (context, index) {
                      final p = mencariProduk[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman detail produk atau pemesanan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PesanProduk(produk: p),
                            ),
                          );
                        },
                        child: Card(
                          color: const Color.fromARGB(255, 255, 115, 185),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(
                                p['NamaProduk'] ?? 'Produk tidak tersedia',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Harga: Rp ${p['Harga'] != null ? double.parse(p['Harga'].toString()).toStringAsFixed(2) : 'Tidak tersedia'}",
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white)),
                                Text(
                                    "Stok: ${p['Stok']?.toString() ?? 'Tidak tersedia'}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    shadows: [
                                      Shadow(
                                          color: Colors.white,
                                          blurRadius: 5,
                                          offset: Offset(2, 2))
                                    ],
                                  ),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateProduk(
                                            ProdukID: p['ProdukID'] ?? 0)),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    shadows: [
                                      Shadow(
                                          color: Colors.white,
                                          blurRadius: 5,
                                          offset: Offset(2, 2))
                                    ],
                                  ),
                                  onPressed: () =>
                                      konfirmasiHapus(p['ProdukID']),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InsertProduk())),
        backgroundColor: const Color.fromARGB(121, 255, 0, 128),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    cari.dispose();
    super.dispose();
  }
}
