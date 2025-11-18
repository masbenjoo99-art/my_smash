import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class FabricRecyclingScreen extends StatelessWidget {
  const FabricRecyclingScreen({Key? key}) : super(key: key);

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
                margin: const EdgeInsets.only(top: 45, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFF216BC2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
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
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Daur Ulang Limbah Kain',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Main Image
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/fabric.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Introduction Text
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Daur ulang limbah kain adalah proses mengolah sisa kain atau pakaian bekas menjadi produk baru. Cara ini membantu mengurangi limbah tekstil, menghemat sumber daya, dan mengubah kain bekas menjadi barang yang lebih bernilai.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Benefits Section
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Manfaat Daur Ulang Kain',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Benefits Grid
                      _buildBenefitsGrid(context),
                      const SizedBox(height: 35),

                      // Recycling Process Section
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tahapan Proses Daur Ulang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Process Steps
                      _buildRecyclingProcess(),
                      const SizedBox(height: 30),
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

  Widget _buildBenefitsGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final benefits = [
      _BenefitItem(
        title: 'Menghemat Sumber Daya Alam',
        image: 'assets/images/sumber.png',
      ),
      _BenefitItem(
        title: 'Peluang Usaha',
        image: 'assets/images/peluang.png',
      ),
      _BenefitItem(
        title: 'Kurangi Polusi Mikroplastik',
        image: 'assets/images/time.png',
      ),
    ];

    // Responsive grid layout
    if (screenWidth < 600) {
      // Mobile - Single column
      return Column(
        children: benefits.map((benefit) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(benefit.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    benefit.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      // Tablet/Desktop - 3 columns
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: benefits.map((benefit) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(benefit.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    benefit.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildRecyclingProcess() {
    final processSteps = [
      _ProcessStep(
        title: 'Pengumpulan & Pemilihan',
        description:
            'Kain dikumpulkan dan dipilah berdasarkan jenis dan kualitas',
      ),
      _ProcessStep(
        title: 'Pembersihan',
        description: 'Kain dibersihkan dari kotoran dan zat kimia',
      ),
      _ProcessStep(
        title: 'Pemotongan',
        description: 'Kain dipotong dan dihancurkan menjadi serat',
      ),
      _ProcessStep(
        title: 'Pengolahan Ulang',
        description: 'Serat diolah menjadi bahan baku baru',
      ),
      _ProcessStep(
        title: 'Pembuatan Produk Baru',
        description: 'Bahan baku digunakan untuk produk tekstil baru',
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: processSteps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Number
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF216BC2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Step Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step.description,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow Icon
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              // Divider (except for last item)
              if (index < processSteps.length - 1)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  color: const Color(0xFFE0E0E0),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _BenefitItem {
  final String title;
  final String image;

  _BenefitItem({
    required this.title,
    required this.image,
  });
}

class _ProcessStep {
  final String title;
  final String description;

  _ProcessStep({
    required this.title,
    required this.description,
  });
}
