import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class FoodWasteScreen extends StatelessWidget {
  const FoodWasteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: const Color(0xFFE8EAF2),
        child: Column(
          children: [
            // Header Section with Image
            Container(
              width: screenWidth,
              height: screenHeight * 0.3,
              color: const Color(0xFFBCCDDC),
              child: Stack(
                children: [
                  // Title
                  Positioned(
                    left: 0,
                    top: 20,
                    child: SizedBox(
                      width: screenWidth,
                      child: const Text(
                        'Sampah Sayur dan Buah',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1B314F),
                          fontSize: 21,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  // Image
                  Positioned(
                    right: 20,
                    top: 50,
                    child: Container(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/sampah_sayur.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    // What is Food Waste Section
                    Container(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Apa itu Sampah Sayur & Buah?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Sampah organik yang berasal dari sisa sayuran dan buah-buahan. Sampah ini dapat terurai secara alami dan bisa dimanfaatkan kembali',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Common Sources Section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sumber Umum',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Sources Grid
                    _buildSourcesGrid(context),
                    const SizedBox(height: 25),

                    // Why Important Section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kenapa Penting Dikelola?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Importance Grid
                    _buildImportanceGrid(),
                    const SizedBox(height: 25),

                    // Management Methods Section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cara Mengelola Sampah Sayur dan Buah',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Management Methods List
                    _buildManagementMethods(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildSourcesGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 54) / 3; // Account for padding and spacing

    final sources = [
      _SourceItem(
        title: 'Rumah Tangga',
        image: 'assets/images/rumah.png',
      ),
      _SourceItem(
        title: 'Restoran',
        image: 'assets/images/restoran.png',
      ),
      _SourceItem(
        title: 'Pasar',
        image: 'assets/images/pasar.png',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: sources.map((source) {
        return Container(
          width: itemWidth,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(source.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                source.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildImportanceGrid() {
    final importanceItems = [
      _ImportanceItem(
        title: 'Menarik Hama',
        image: 'assets/images/hama.png',
      ),
      _ImportanceItem(
        title: 'Bau Busuk',
        image: 'assets/images/bau.png',
      ),
      _ImportanceItem(
        title: 'Emisi Gas Metana',
        image: 'assets/images/gas.png',
      ),
      _ImportanceItem(
        title: 'TPA Cepat Penuh',
        image: 'assets/images/tpa.png',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: importanceItems.length,
      itemBuilder: (context, index) {
        final item = importanceItems[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildManagementMethods() {
    final methods = [
      'Pembuatan Pupuk Kompos',
      'Pakan Ternak',
      'Produksi Biogas',
      'Pembuatan Eco-Enzyme',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: methods.asMap().entries.map((entry) {
          final index = entry.key;
          final method = entry.value;
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  method,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (index < methods.length - 1)
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFA7A7A7),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SourceItem {
  final String title;
  final String image;

  _SourceItem({
    required this.title,
    required this.image,
  });
}

class _ImportanceItem {
  final String title;
  final String image;

  _ImportanceItem({
    required this.title,
    required this.image,
  });
}
