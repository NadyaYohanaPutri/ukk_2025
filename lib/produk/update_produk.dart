import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateProduk extends StatefulWidget {
  final int ProdukID;
  const UpdateProduk({super.key, required this.ProdukID});

  @override
  State<UpdateProduk> createState() => _UpdateProdukState();
}

class _UpdateProdukState extends State<UpdateProduk> {
  final fromKey = GlobalKey<FormState>();
  final nama = TextEditingController();
  final harga = TextEditingController();
  final stok = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    dataProduk();
  }

  Future<void> dataProduk() async {
    final data = await supabase
        .from('produk')
        .select()
        .eq('ProdukID', widget.ProdukID)
        .single();

    setState(() {
      nama.text = data['NamaProduk'] ?? '';
      harga.text = data['Harga'] ?? '';
      stok.text = data['Stok'] ?? '';
    });
  }

  Future<void> updateProduk() async {
    if (fromKey.currentState!.validate()) {
      await supabase.from('produk').update({
        'NamaProduk': nama.text,
        'Harga': harga.text,
        'Stok': stok.text,
      }).eq('ProdukID', widget.ProdukID);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil diperbarui!')),
      );

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(121, 255, 0, 128),
        title: Text(
          'Edit Produk',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: fromKey,
          child: Column(
            children: [
              _buildTextField(nama, 'Nama Produk'),
              SizedBox(height: 10,),
              _buildTextField(harga, 'Harga'),
              SizedBox(height: 10,),
              _buildTextField(stok, 'Stok'),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (value) => value!.isEmpty ? '$label tidak boleh kosong' : null,
    );
  }
}
