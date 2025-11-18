import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'smart_drop_box_search_screen.dart';

class SmartDropBoxSearchPage extends StatelessWidget {
  const SmartDropBoxSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Kalau di BankSearchPage kamu pakai CustomAppBar / AppBar lain,
      // samakan saja di sini.
      appBar: const CustomAppBar(),

      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // ====== BANNER ATAS======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
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
            ),

            const SizedBox(height: 24),

            // ====== KARTU PUTIH PENCARIAN SDB ======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const SmartDropBoxSearchScreen(),
              ),
            ),
                        // tombol besar di bawah card (opsional kalau mau sama persis)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF216BC2),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.my_location, color: Colors.white),
                  onPressed: () {
                    // panggil fungsi _showAllBandungDropBoxes()
                    // (bisa kamu expose lewat callback, atau sementara kosong)
                  },
                  label: const Text(
                    'Gunakan Lokasi Saat Ini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
    
  }
}

