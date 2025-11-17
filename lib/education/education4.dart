import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class WasteManagementScreen extends StatelessWidget {
  const WasteManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cara Mengelola Sampah',
              style: TextStyle(
                color: Color(0xFF216BC2),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/waste.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Agar sampah tidak menjadi masalah lingkungan, perlu dilakukan pengelolaan yang baik dan berkelanjutan. Berikut beberapa metode pengelolaan sampah:\n\n"
                "1. Pengurangan (Reduce)\n"
                "- Mengurangi penggunaan barang sekali pakai\n"
                "- Membawa tas belanja sendiri\n"
                "- Menghindari produk dengan kemasan berlebihan\n\n"
                "2. Penggunaan Kembali (Reuse)\n"
                "- Menggunakan kembali botol/wadah\n"
                "- Mendonasikan pakaian bekas\n"
                "- Memanfaatkan kedua sisi kertas\n\n"
                "3. Daur Ulang (Recycle)\n"
                "- Mengolah kertas bekas menjadi kertas daur ulang\n"
                "- Membuat kerajinan dari plastik bekas\n"
                "- Melelehkan logam untuk industri\n\n"
                "4. Pengolahan Sampah Organik\n"
                "- Komposting: mengubah sampah organik menjadi pupuk\n"
                "- Biogas: menghasilkan energi dari sampah organik\n\n"
                "5. Pemusnahan Sampah\n"
                "- Pembakaran dengan teknologi ramah lingkungan\n"
                "- Penimbunan sanitasi yang terkontrol\n\n"
                "6. Pengelolaan Sampah Berbahaya\n"
                "- Limbah medis dihancurkan dengan insinerator khusus\n"
                "- Baterai dan elektronik didaur ulang secara khusus",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3), // Education index
    );
  }
}