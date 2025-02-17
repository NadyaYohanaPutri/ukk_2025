import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InsertProduk extends StatefulWidget {
  const InsertProduk({super.key});

  @override
  State<InsertProduk> createState() => _InsertProdukState();
}

class _InsertProdukState extends State<InsertProduk> {
  final formKey = GlobalKey<FormState>();
  final nama = TextEditingController();
  final harga = TextEditingController();
  final stok = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> simpan() async {
    if (formKey.currentState!.validate()) {
      // Untuk mengcek apakah NamaProduk sudah ada
      final simpanData = await supabase
          .from('produk')
          .select('NamaProduk')
          .eq('NamaProduk', nama.text)
          .maybeSingle();

      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data berhasil disimpan')));

      if (simpanData != null) {
        // Untuk menampilkan pesan error jika data sudah ada
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak boleh ada data ganda!')),
        );
        return;
      }

      // Untuk menyimpan data jika data belum ada
      await supabase.from('produk').insert({
        'NamaProduk': nama.text,
        'Harga': harga.text,
        'Stok': stok.text,
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    // {bool isNumber = false} = Input akan menerima teks biasa
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : [], // [FilteringTextInputFormatter.digitsOnly] = Mencegah pengguna mengetik huruf atau simbol
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            const Text('Tambah Produk', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(121, 255, 0, 128),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildTextField(nama, 'Nama Produk'),
              const SizedBox(height: 10),
              _buildTextField(harga, 'Harga', isNumber: true),
              const SizedBox(height: 10),
              _buildTextField(stok, 'Stok',
                  isNumber:
                      true), // isNumber: true = Input hanya akan menerima angka
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: simpan,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(121, 255, 0, 128)),
                child:
                    const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
