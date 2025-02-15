import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/produk/index_produk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertProduk extends StatefulWidget {
  const InsertProduk({super.key});

  @override
  State<InsertProduk> createState() => _InsertProdukState();
}

class _InsertProdukState extends State<InsertProduk> {
  final fromKey = GlobalKey<FormState>();
  final nama = TextEditingController();
  final harga = TextEditingController();
  final stok = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> simpanProduk() async {
    if (fromKey.currentState!.validate()) {
      final sambungData = await supabase
          .from('produk')
          .select('NamaProduk')
          .eq('NamaProduk', nama.text)
          .maybeSingle();

      if (sambungData != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Tidak boleh ada data produk ganda!')));
        return;
      }
      await supabase.from('produk').insert(
          {'NamaProduk': nama.text, 'Harga': harga.text, 'Stok': stok.text});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const IndexProduk()));
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (value) =>
          (value == null || value.isEmpty) ? '$label tidak boleh kosong' : null,
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
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: fromKey,
          child: Column(
            children: [
              _buildTextField(nama, 'Nama Pelanggan'),
              const SizedBox(height: 10),
              _buildTextField(harga, 'Alamat', isNumber: true),
              const SizedBox(height: 10),
              _buildTextField(stok, 'Nomor Telepon', isNumber: true), // isNumber: true = Input hanya akan menerima angka
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: simpanProduk,
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(121, 255, 0, 128)),
                child: const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}