import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class WasteTypesScreen extends StatelessWidget {
  const WasteTypesScreen({Key? key}) : super(key: key);

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
                margin: const EdgeInsets.only(top: 45, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFF90BCFD),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // Title
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: const Text(
                          'Jenis-Jenis Sampah Berdasarkan Sumbernya',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Main Image
                      Container(
                        width: screenWidth * 0.7,
                        height: screenHeight * 0.22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/jenis_sampah.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Waste Type Cards Grid
                      _buildWasteTypesGrid(context),
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

  Widget _buildWasteTypesGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 56) / 2; // Account for padding and spacing

    final wasteTypes = [
      _WasteType(
        title: 'Rumah Tangga',
        description:
            'Sampah aktivitas rumah: sisa makanan, plastik, botol, dan kertas',
        icon: Icons.home_outlined,
      ),
      _WasteType(
        title: 'Industri',
        description:
            'Sampah Limbah Pabrik: limbah kimia, logam berat, dan bahan beracun',
        icon: Icons.factory_outlined,
      ),
      _WasteType(
        title: 'Medis',
        description:
            'Sampah fasilitas kesehatan: jarum suntik bekas, obat kedaluwarsa, perban',
        icon: Icons.medical_services_outlined,
      ),
      _WasteType(
        title: 'Komersial',
        description:
            'Sampah dari Toko, Restoran, Pusat Belanja: kardus, bungkus makanan, plastik, kertas',
        icon: Icons.shopping_cart_outlined,
      ),
      _WasteType(
        title: 'Pertanian',
        description:
            'Sampah dari aktivitas pertanian: jerami, pestisida, pupuk kimia',
        icon: Icons.agriculture_outlined,
      ),
      _WasteType(
        title: 'Konstruksi',
        description:
            'Sampah dari proyek: puing bangunan, beton, kayu, material bekas',
        icon: Icons.construction_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // For mobile screens, use 2 columns
        if (screenWidth < 600) {
          return Column(
            children: [
              for (int i = 0; i < wasteTypes.length; i += 2)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildWasteTypeCard(wasteTypes[i]),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: i + 1 < wasteTypes.length
                            ? _buildWasteTypeCard(wasteTypes[i + 1])
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else {
          // For tablet screens, use 3 columns
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.6,
            ),
            itemCount: wasteTypes.length,
            itemBuilder: (context, index) {
              return _buildWasteTypeCard(wasteTypes[index]);
            },
          );
        }
      },
    );
  }

  Widget _buildWasteTypeCard(_WasteType wasteType) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF216BC2),
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
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              wasteType.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  wasteType.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Description
                Expanded(
                  child: Text(
                    wasteType.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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

class _WasteType {
  final String title;
  final String description;
  final IconData icon;

  _WasteType({
    required this.title,
    required this.description,
    required this.icon,
  });
}
