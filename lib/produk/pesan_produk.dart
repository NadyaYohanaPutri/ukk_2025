import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PesanProduk extends StatefulWidget {
  final Map<String, dynamic> produk;

  PesanProduk({Key? key, required this.produk}) : super(key: key);

  @override
  _PesanProdukState createState() => _PesanProdukState();
}

class _PesanProdukState extends State<PesanProduk> {
  final supabase = Supabase.instance.client;
  int subtotal = 0;
  int jumlahProduk = 0;

  void updateJumlahProduk(int delta) {
    int stok = widget.produk['Stok'] ?? 0;
    setState(() {
      jumlahProduk = max(0, min(jumlahProduk + delta, stok));
    });
  }

  Future<void> simpanProduk(
      int ProdukID, int PenjualanID, int JumlahProduk, int Subtotal) async {
    if (jumlahProduk == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah produk harus lebih dari 0!')),
      );
      return;
    }

    try {
      int total = widget.produk['Harga'] ?? 0 * jumlahProduk;
      int totalHarga = total * jumlahProduk;

      final penjualan = await supabase
          .from('penjualan')
          .insert({
            'PelangganID': 1,
            'TanggalPenjualan': DateTime.now().toIso8601String(),
            'TotalHarga': subtotal,
          })
          .select('PenjualanID')
          .single();

      int penjualanId = penjualan['PenjualanID'];

      await supabase.from('detailpenjualan').insert({
        'ProdukID': widget.produk['ProdukID'],
        'PenjualanID': PenjualanID,
        'JumlahProduk': JumlahProduk,
        'Subtotal': Subtotal
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesanan berhasil disimpan!')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      print('Error menyimpan pesanan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan pesanan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final produk = widget.produk;
    final total = produk['Harga'] ?? 0;
    final produkId = produk['ProdukID'] ?? 0;
    final penjualanId = 1;
    final totalHarga = jumlahProduk * total;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(121, 255, 0, 128),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(121, 255, 0, 128)),
            child: Center(
              child: SizedBox(
                width: 300,
                height: 330,
                child: Card(
                  margin: const EdgeInsets.all(20),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            produk['NamaProduk'] ??
                                'Nama Produk Tidak Tersedia',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text('Harga: Rp$total',
                            style: const TextStyle(fontSize: 18)),
                        Text(
                            'Stok Tersedia: ${produk['Stok'] ?? 'Tidak Tersedia'}',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: jumlahProduk > 0
                                  ? () => updateJumlahProduk(-1)
                                  : null,
                              icon: const Icon(Icons.remove_circle,
                                  size: 32, color: Colors.red),
                            ),
                            Text('$jumlahProduk',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => updateJumlahProduk(1),
                              icon: const Icon(Icons.add_circle,
                                  size: 32, color: Colors.green),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: jumlahProduk > 0
                                  ? () async {
                                      await simpanProduk(produkId, penjualanId,
                                          jumlahProduk, subtotal);
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (jumlahProduk > 0)
                                    ? const Color.fromARGB(121, 255, 0, 128)
                                    : Colors.grey,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Text('Pesan (Rp$totalHarga)',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
