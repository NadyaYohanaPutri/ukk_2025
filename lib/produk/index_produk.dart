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
    dataProduk();
    cari.addListener(pencarianProduk);
  }

  Future<void> dataProduk() async {
    try {
      final data = await supabase.from('produk').select();
      setState(() {
        produkList = List<Map<String, dynamic>>.from(data);
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

  Future<void> hapusDataProduk(int id) async {
    await supabase.from('produk').delete().eq('ProdukID', id);
    dataProduk(); // Refresh data setelah menghapus
  }

  void konfirmasiHapus(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus produk'),
        content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          TextButton(
              onPressed: () {
                hapusDataProduk(id);
                Navigator.pop(context);
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Data Produk',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: cari,
              decoration: InputDecoration(
                labelText: "Cari Produk...",
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
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dua kartu per baris
                      crossAxisSpacing:
                          8, // Jarak horizontal (lebar) antar kartu
                      mainAxisSpacing: 8, // Jarak vertikal (tinggi) antar kartu
                      childAspectRatio:
                          2 / 1, // Rasio aspek kartu ((2)lebar : (1)tinggi)
                    ),
                    itemCount: mencariProduk.length,
                    itemBuilder: (context, index) {
                      final p = mencariProduk[index];
                      return GestureDetector(
                          // GestureDetector untuk menangani event klik sebagai alternatif IconButton
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PesanProduk(produk: p)));
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Text(
                                  p['NamaProduk'] ?? 'Produk tidak tersedia',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p['Harga'] ?? 'Tidak tersedia',
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey)),
                                  Text(p['Stok'] ?? 'Tidak tersedia',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateProduk(
                                              ProdukID: p['ProdukID'] ?? 0)),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        konfirmasiHapus(p['ProdukID']),
                                  ),
                                ],
                              ),
                            ),
                          ));
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
