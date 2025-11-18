import 'package:flutter/material.dart';
import 'package:my_smash/widgets/app_bar.dart';
import 'package:my_smash/widgets/bottom_nav_bar.dart';
import 'package:my_smash/screens/smart_drop_box_search_screen.dart';

class SmartDropBoxSearchPage extends StatelessWidget {
  const SmartDropBoxSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Banner sama seperti di Home =====
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/banner1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ===== KARTU PUTIH, MODELNYA SAMA DENGAN BANK SAMPAH =====
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Smart Drop Box',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Cari smart drop box di sekitarmu!',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Semua Lokasi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // BAGIAN ISI PENCARIAN SDB
                      // SmartDropBoxSearchScreen sudah berisi:
                      // - header kecil
                      // - search field
                      // - tombol "Gunakan Lokasi Saat Ini"
                      // - list kota + SDB
                      SizedBox(
                        height: screenHeight * 0.6, // biar Expanded di dalamnya punya batas
                        child: const SmartDropBoxSearchScreen(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}
