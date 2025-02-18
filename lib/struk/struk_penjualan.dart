import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class Struk extends StatelessWidget {
  final List<Map<String, dynamic>> selectedPenjualan;
  final String tanggalPesanan;
  final int totalHarga;

  const Struk({
    super.key,
    required this.selectedPenjualan,
    required this.tanggalPesanan,
    required this.totalHarga,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(121, 255, 0, 128),
      title: const Text(
        'Struk Pembelian',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Pesanan: $tanggalPesanan',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Harga: Rp ${totalHarga.toString()}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Detail Penjualan:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Column(
              children: selectedPenjualan.map((penjualan) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal: ${penjualan['TanggalPenjualan']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Pelanggan ID: ${penjualan['PelangganID']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Total Harga: Rp ${penjualan['TotalHarga']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Tutup dialog
          },
          child: const Text(
            'Tutup',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Struk telah dicetak!')),
            );
          },
          child: const Text(
            'Cetak Struk',
            style: TextStyle(color: Color.fromARGB(121, 255, 0, 128)),
          ),
        ),
      ],
    );
  }
}
