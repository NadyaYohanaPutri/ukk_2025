import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexDetailPenjualan extends StatefulWidget {
  const IndexDetailPenjualan({super.key});

  @override
  State<IndexDetailPenjualan> createState() => _IndexDetailPenjualanState();
}

class _IndexDetailPenjualanState extends State<IndexDetailPenjualan> {
  final SupabaseClient supabase = Supabase.instance.client;

  final TextEditingController cari = TextEditingController();
  List<Map<String, dynamic>> detailList = [];
  List<Map<String, dynamic>> mencariDetail = [];

  @override
  void initState() {
    super.initState();
    ambilDetail();
    cari.addListener(pencarianDetail);
  }

  Future<void> ambilDetail() async {
    try {
      final detail = await supabase.from('detailpenjualan').select();
      setState(() {
        detailList = List<Map<String, dynamic>>.from(detail);
        mencariDetail = detailList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> tambahKePenjualan(int TotalHarga, int PelangganID) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('detailpenjualan').insert({
      'TotalHarga': TotalHarga,
      'PelangganID': PelangganID,
    });
    if (response == null) {
      print('error');
    }
  }

  // Digunakan untuk melakukan pencarian pelanggan berdasarkan input pengguna di Search Bar
  void pencarianDetail() {
    setState(() {
      mencariDetail = detailList
          .where((detail) => detail['PenjualanID']
              .toLowerCase()
              .contains(cari.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: cari,
              decoration: InputDecoration(
                labelText: "Cari Detail...",
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
              child: mencariDetail.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak Ada Data Detail',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(121, 255, 0, 128)),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: mencariDetail.length,
                      itemBuilder: (context, index) {
                        final d = mencariDetail[index];
                        return Card(
                          color: const Color.fromARGB(255, 255, 115, 185),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(
                                'ID Detail: ${d['DetailID']?.toString() ?? 'DetailID tidak tersedia'}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'ID Penjualan: ${d['PenjualanID']?.toString() ?? 'PenjualanID tidak tersedia'}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(
                                    'ID Produk: ${d['ProdukID']?.toString() ?? 'ProdukID tidak tersedia'}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(
                                    'Jumlah Produk: ${d['JumlahProduk']?.toString() ?? 'Jumlah Produk tidak tersedia'}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(
                                    'Total Harga: ${d['Subtotal']?.toString() ?? 'Subtotal tidak tersedia'}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
        ],
      ),
    ));
  }
}
