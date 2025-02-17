import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IndexDetailPenjualan extends StatefulWidget {
  const IndexDetailPenjualan({super.key});

  @override
  State<IndexDetailPenjualan> createState() => _IndexDetailPenjualanState();
}

class _IndexDetailPenjualanState extends State<IndexDetailPenjualan> {
  final supabase = Supabase.instance.client;
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
      final data = await supabase.from('detailpenjualan').select();
      setState(() {
        detailList = List<Map<String, dynamic>>.from(data);
        mencariDetail = detailList;
      });
    } catch (e) {
      print('Error: $e');
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: cari,
              decoration: InputDecoration(
                labelText: "Cari Detail...",
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
                        final p = mencariDetail[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        );
                      },
                    ))
        ],
      ),
    );
  }
}
