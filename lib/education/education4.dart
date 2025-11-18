import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class WasteManagementScreen extends StatelessWidget {
  const WasteManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Column(
          children: [
            // Background Blue Container
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 45, left: 23, right: 23),
                decoration: const BoxDecoration(
                  color: Color(0xFF216BC2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // Title Section
                      const Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Cara mengelola sampah',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Pilah, Kelola, dan Kurangi Dampaknya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Main Image
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/tong_sampah.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Introduction Text
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Agar sampah tidak menjadi masalah lingkungan, perlu dilakukan pengelolaan yang baik dan berkelanjutan. berikut adalah beberapa metode pengelolaan sampah:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Waste Management Cards
                      _buildWasteManagementCard(
                        iconColor: const Color(0xFFFF723B),
                        icon: Icons.remove_circle_outline,
                        title: 'Reduce',
                        items: [
                          'Kurangi barang sekali pakai',
                          'Bawa tas belanja sendiri',
                          'Pilih produk dengan kemasan minimal',
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildWasteManagementCard(
                        iconColor: const Color(0xFF176FD4),
                        icon: Icons.repeat,
                        title: 'Reuse',
                        items: [
                          'Gunakan ulang botol kaca/plastik',
                          'Donasikan pakaian layak pakai',
                          'Gunakan kertas untuk cetak bolak balik',
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildWasteManagementCard(
                        iconColor: const Color(0xFFFCBB04),
                        icon: Icons.recycling,
                        title: 'Recycle',
                        items: [
                          'Olah kertas bekas jadi kertas daur ulang',
                          'Daur ulang plastik jadi barang baru',
                          'Lelehkan logam untuk industri',
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildWasteManagementCard(
                        iconColor: const Color(0xFF138B47),
                        icon: Icons.eco,
                        title: 'Sampah Organik',
                        items: [
                          'Komposting: Pupuk tanaman',
                          'Biogas: Sumber energi dari sampah organik',
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildWasteManagementCard(
                        iconColor: const Color(0xFFE32B28),
                        icon: Icons.delete_forever,
                        title: 'Pemusnahan Sampah',
                        items: [
                          'Pembakaran: Mengurangi volume sampah dengan suhu tinggi',
                          'Penimbunan: sampah ditimbun dengan sistem sanitasi yang baik',
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildWasteManagementCard(
                        iconColor: const Color(0xFF29E123),
                        icon: Icons.warning_amber_rounded,
                        title: 'Pengelolaan Sampah Berbahaya',
                        items: [
                          'Baterai dan Elektronik dikumpulkan dan didaur ulang',
                          'Sampah B3 harus dikelola secara khusus sesuai regulasi',
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildWasteManagementCard({
    required Color iconColor,
    required IconData icon,
    required String title,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                // Items
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, right: 8),
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
