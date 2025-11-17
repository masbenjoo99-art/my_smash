import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class OrganicWasteScreen extends StatelessWidget {
  const OrganicWasteScreen({Key? key}) : super(key: key);

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
              'Sampah Organik',
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
                  image: AssetImage('assets/images/organic_waste.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. Pengertian Sampah Organik",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Sampah yang berasal dari bahan alami seperti sisa makanan, dedaunan, atau limbah pertanian yang dapat terurai secara alami oleh mikroorganisme.",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "2. Jenis-Jenis Sampah Organik",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Sampah Basah: Sisa makanan, buah/sayur busuk\n"
                    "• Sampah Kering: Dedaunan kering, ranting\n"
                    "• Sampah Rumah Tangga: Limbah dapur\n"
                    "• Sampah Pertanian: Jerami, batang jagung",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "3. Contoh Sampah Organik",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Dari dapur: Kulit buah, ampas teh/kopi\n"
                    "• Dari kebun: Rumput, daun kering\n"
                    "• Dari industri: Ampas tahu, limbah sawit",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "4. Dampak Positif",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Bisa diolah jadi pupuk kompos\n"
                    "• Sumber energi biogas\n"
                    "• Meningkatkan kesuburan tanah\n"
                    "• Mengurangi sampah di TPA",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "5. Dampak Negatif",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Menimbulkan bau tidak sedap\n"
                    "• Menghasilkan gas metana\n"
                    "• Mengundang hama penyakit\n"
                    "• Mencemari tanah dan air",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3), // Education index
    );
  }
}