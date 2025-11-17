import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class EducationDetailScreen2 extends StatelessWidget {
  const EducationDetailScreen2({Key? key}) : super(key: key);

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
              'Kenali Tempat Sampah',
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
                  image: AssetImage('assets/images/trans_bins.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "1. Sampah Plastik\n"
                "Sulit terurai dan dapat mencemari lingkungan jika tidak dikelola dengan baik.\n"
                "Terbuat dari bahan sintetis yang sulit terurai secara alami.\n"
                "Memerlukan waktu ratusan hingga ribuan tahun untuk terdegradasi di alam.\n"
                "Dapat mencemari lingkungan, terutama laut, dan berbahaya bagi satwa.\n"
                "Mudah terbakar dan menghasilkan gas beracun saat dibakar.\n\n"
                "2. Sampah Kertas\n"
                "Dapat didaur ulang menjadi kertas baru.\n"
                "Mudah terurai secara alami.\n"
                "Bisa didaur ulang berkali-kali hingga seratnya melemah.\n"
                "Tidak mencemari lingkungan jika dikelola dengan baik.\n\n"
                "3. Sampah Kaca\n"
                "Bisa digunakan kembali atau dilebur untuk membuat produk baru.\n"
                "Tidak mudah terurai tetapi dapat didaur ulang tanpa kehilangan kualitasnya.\n"
                "Tahan terhadap suhu tinggi dan bahan kimia.\n"
                "Pecahan kaca dapat berbahaya bagi manusia dan hewan.\n\n"
                "4. Sampah Logam\n"
                "Bisa didaur ulang menjadi bahan baku industri.\n"
                "Memiliki nilai ekonomis tinggi karena dapat didaur ulang berkali-kali tanpa kehilangan sifatnya.\n"
                "Tahan lama dan tidak mudah terurai di alam.\n"
                "Beberapa logam dapat berkarat dan mencemari lingkungan.\n\n"
                "5. Sampah Elektronik\n"
                "Berasal dari perangkat elektronik yang sudah tidak terpakai.\n"
                "Mengandung bahan berbahaya seperti merkuri, timbal, dan kadmium yang bisa mencemari tanah dan air.\n"
                "Dapat mengandung komponen yang masih bernilai, seperti emas dan perak dalam papan sirkuit.\n"
                "Tidak boleh dibuang sembarangan karena bisa menyebabkan pencemaran lingkungan.",
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