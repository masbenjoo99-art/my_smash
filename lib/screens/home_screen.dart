import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/waste_category.dart';
import '../widgets/waste_location_card.dart';
import '../screens/main_screen.dart';
import '../screens/bank_search_page.dart';
import '../screens/smart_drop_box_search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // buka tab Bank Sampah di MainScreen
  void _openBankSampahTab(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MainScreen(initialTabIndex: 0),
      ),
    );
  }

  // buka tab Smart Drop Box di MainScreen
  void _openSmartDropBoxTab(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MainScreen(initialTabIndex: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // BANNER ATAS
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

              // CARD BANK SAMPAH
              WasteLocationCard(
                title: 'Bank Sampah',
                description: 'Cari bank sampah di sekitarmu!',
                onSearch: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BankSearchPage(),
                      ),
                    );
                  },
                  footerAssetPath: 'assets/images/icon_bank_sampah.png',
                ),

              const SizedBox(height: 16),

              // CARD SAMPAH YANG DAPAT DI DAURULANG
              Card(
                elevation: 1,
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
                    children: const [
                      Text(
                        'Sampah Yang Dapat Di Daurulang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      WasteCategoriesGrid(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // CARD SMART DROP BOX
                WasteLocationCard(
                  title: 'Smart Drop Box',
                  description: 'Cari smart drop box di sekitarmu!',
                  onSearch: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SmartDropBoxSearchScreen(),
                      ),
                    );
                  },
                  footerAssetPath: 'assets/images/icon_smart_drop_box.png',
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
