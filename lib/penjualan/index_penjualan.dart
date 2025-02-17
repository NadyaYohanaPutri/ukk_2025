import 'package:flutter/material.dart';
import 'package:flutter_application_1/pelanggan/insert_pelanggan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexPenjualan extends StatefulWidget {

  const IndexPenjualan({super.key});

  @override
  State<IndexPenjualan> createState() => _IndexPenjualanState();
}

class _IndexPenjualanState extends State<IndexPenjualan> {
  DateTime tanggal = DateTime.now();
  final supabase = Supabase.instance.client;
  final TextEditingController cari = TextEditingController();
  List<Map<String, dynamic>> penjualanList = [];
  List<Map<String, dynamic>> mencariPenjualan = [];

  @override
  void initState() {
    super.initState();
    ambilPenjualan();
    cari.addListener(pencarianPenjualan);
  }

  Future<void> ambilPenjualan() async {
    try {
      final data = await supabase.from('penjualan').select();
      setState(() {
        penjualanList = List<Map<String, dynamic>>.from(data);
        mencariPenjualan = penjualanList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // Digunakan untuk melakukan pencarian pelanggan berdasarkan input pengguna di Search Bar
  void pencarianPenjualan() {
    setState(() {
      mencariPenjualan = penjualanList
          .where((penjualan) => penjualan['PelangganID']
              .toLowerCase()
              .contains(cari.text.toLowerCase()))
          .toList();
    });
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
                labelText: "Cari Penjualan...",
                prefixIcon: const Icon(Icons.search,
                    color: Color.fromARGB(121, 255, 0, 128)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: mencariPenjualan.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak Ada Data Penjualan',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(121, 255, 0, 128)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: mencariPenjualan.length,
                    itemBuilder: (context, index) {
                      final p = mencariPenjualan[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(
                              p['TanggalPenjualan'] ?? 'Tanggal tidak tersedia',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p['TotalHarga'] ?.toString() ?? 'Total Tidak tersedia',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey)),
                              Text(p['PelangganID'] ?.toString() ?? 'Tidak tersedia',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
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
            MaterialPageRoute(builder: (context) => const InsertPelanggan())),
        backgroundColor: const Color.fromARGB(121, 255, 0, 128),
        child: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    cari.dispose();
    super.dispose();
  }
}
