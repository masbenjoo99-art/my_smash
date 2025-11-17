import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/waste_category.dart';
import '../widgets/waste_location_card.dart';
import '../screens/main_screen.dart'; // ✅ GANTI IMPORT
import '../db/database_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ✅ UPDATE: Navigate ke MainScreen dengan Bank Sampah tab
  Future<void> _openBankSampahTab(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialTabIndex: 0), // Tab Bank Sampah
      ),
    );
  }

  // ✅ TAMBAHAN: Navigate ke MainScreen dengan Smart Drop Box tab
  Future<void> _openSmartDropBoxTab(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialTabIndex: 1), // Tab Smart Drop Box
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Banner placeholder
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

              // ✅ UPDATE: Bank Sampah Section
              WasteLocationCard(
                title: 'Bank Sampah',
                description: 'Cari bank sampah di sekitarmu!',
                onSearch: () => _openBankSampahTab(context), // ✅ UPDATE
              ),

              const SizedBox(height: 24),

              // Waste Categories
              const Text(
                'Sampah Yang Dapat Di Daurulang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              const WasteCategoriesGrid(),

              const SizedBox(height: 24),

              // ✅ UPDATE: Smart Drop Box Section
              WasteLocationCard(
                title: 'Smart Drop Box', // ✅ PERBAIKI TITLE
                description: 'Temukan Smart Drop Box terdekat!', // ✅ UPDATE DESCRIPTION
                onSearch: () => _openSmartDropBoxTab(context), // ✅ UPDATE ACTION
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
