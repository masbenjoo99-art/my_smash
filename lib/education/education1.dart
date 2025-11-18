import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'education2.dart';
import 'education3.dart';
import 'education4.dart';
import 'education5.dart';
import 'education6.dart';
import 'education7.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          children: [
            _buildEducationCard(
              context: context,
              title: 'Kenali Tempat Sampah',
              imagePath: 'assets/images/trans_bins.png',
              screen: const EducationDetailScreen2(),
            ),
            const SizedBox(height: 16),
            _buildEducationCard(
              context: context,
              title: 'Jenis-Jenis Sampah Berdasarkan Sumbernya',
              imagePath: 'assets/images/waste_types.png',
              screen: const WasteTypesScreen(),
            ),
            const SizedBox(height: 16),
            _buildEducationCard(
              context: context,
              title: 'Cara Mengelola Sampah',
              imagePath: 'assets/images/waste.png',
              screen: const WasteManagementScreen(),
            ),
            const SizedBox(height: 16),
            _buildEducationCard(
              context: context,
              title: 'Sampah Sayur & Buah',
              imagePath: 'assets/images/food_waste.png',
              screen: const FoodWasteScreen(),
            ),
            const SizedBox(height: 16),
            _buildEducationCard(
              context: context,
              title: 'Sampah Organik',
              imagePath: 'assets/images/organic_waste.png',
              screen: const OrganicWasteScreen(),
            ),
            const SizedBox(height: 16),
            _buildEducationCard(
              context: context,
              title: 'Daur Ulang Limbah Kain',
              imagePath: 'assets/images/fabric.png',
              screen: FabricRecyclingScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildEducationCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required Widget screen,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF216BC2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Education Image
          Container(
            width: 120,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Education Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => screen),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC6F7FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Baca Lebih Lengkap',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
