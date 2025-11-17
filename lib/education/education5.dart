import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class FoodWasteScreen extends StatelessWidget {
  const FoodWasteScreen({Key? key}) : super(key: key);

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
              'Sampah Sayur dan Buah',
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
                  image: AssetImage('assets/images/food_waste.png'),
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
                    "1. Pengertian Sampah Sayur dan Buah",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Sampah organik dari sisa sayuran dan buah-buahan yang tidak dikonsumsi, termasuk kulit, batang, biji, atau bagian yang membusuk.",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "2. Sumber Utama",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Rumah Tangga: Sisa memasak dan buah busuk\n"
                    "• Pasar: Sayur/buah tidak laku\n"
                    "• Restoran: Sisa makanan pelanggan\n"
                    "• Industri: Limbah pengolahan makanan",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "3. Karakteristik",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Cepat membusuk\n"
                    "• Kandungan air tinggi\n"
                    "• Mengandung nutrisi\n"
                    "• Potensi daur ulang tinggi",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "4. Dampak Negatif",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Menghasilkan gas metana\n"
                    "• Mengundang hama\n"
                    "• Pemborosan nutrisi\n"
                    "• Memenuhi TPA lebih cepat",
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  SizedBox(height: 16),
                  Text(
                    "5. Solusi Pengelolaan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "A. Pemilahan Sampah\n"
                    "• Pisahkan sampah organik/anorganik\n"
                    "• Gunakan wadah khusus\n\n"
                    "B. Pemanfaatan Ulang\n"
                    "• Kompos: Pupuk organik\n"
                    "• Pakan ternak: Untuk hewan\n"
                    "• Biogas: Sumber energi\n\n"
                    "C. Pengurangan Sampah\n"
                    "• Beli secukupnya\n"
                    "• Manfaatkan seluruh bagian",
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