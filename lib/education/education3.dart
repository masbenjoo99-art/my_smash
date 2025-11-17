import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class WasteTypesScreen extends StatelessWidget {
  const WasteTypesScreen({Key? key}) : super(key: key);

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
              'Jenis-Jenis Sampah Berdasarkan Sumbernya',
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
                  image: AssetImage('assets/images/waste_types.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "1. Sampah Rumah Tangga\n"
                "Berasal dari aktivitas sehari-hari di rumah seperti sisa makanan, plastik kemasan, botol, dan kertas.\n"
                "- Dihasilkan oleh setiap individu\n"
                "- Terdiri dari sampah organik dan anorganik\n"
                "- Dapat mencemari lingkungan jika tidak dikelola\n\n"
                "2. Sampah Industri\n"
                "Dihasilkan oleh pabrik atau industri, seperti limbah kimia, logam berat, dan bahan beracun.\n"
                "- Skala besar dengan bahan berbahaya\n"
                "- Bisa berbentuk cair, gas, atau padatan\n\n"
                "3. Sampah Medis\n"
                "Berasal dari fasilitas kesehatan seperti rumah sakit dan klinik.\n"
                "- Berpotensi mengandung virus/bakteri\n"
                "- Harus dikelola secara khusus\n\n"
                "4. Sampah Komersial\n"
                "Dihasilkan oleh kegiatan perniagaan seperti toko, pasar, dan restoran.\n"
                "- Banyak sampah kemasan\n"
                "- Volume tinggi di perkotaan\n\n"
                "5. Sampah Pertanian\n"
                "Berasal dari aktivitas pertanian seperti jerami dan pestisida.\n"
                "- Limbah organik atau bahan kimia\n"
                "- Dampak pada kesuburan tanah\n\n"
                "6. Sampah Konstruksi\n"
                "Berasal dari proyek pembangunan seperti puing beton dan kayu.\n"
                "- Bahan bangunan bekas\n"
                "- Dapat digunakan kembali",
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