import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class EducationDetailScreen2 extends StatelessWidget {
  const EducationDetailScreen2({Key? key}) : super(key: key);

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
            // Header Image
            Container(
              width: screenWidth,
              height: screenHeight * 0.35, // 35% of screen height
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sampah_1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content Area
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 23,
                  ),
                  child: Column(
                    children: [
                      // Title
                      const Text(
                        'Kenali Jenis Tempat Sampah',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Divider
                      _buildDivider(),
                      const SizedBox(height: 30),

                      // Waste Type Sections
                      _buildWasteTypeSection(
                        context: context,
                        title: 'Sampah Organik',
                        mainImage: 'assets/images/sampah_2.png',
                        mainImageWidth: screenWidth * 0.46, // 191/412 ≈ 0.46
                        mainImageHeight: 127,
                        exampleImages: [
                          'assets/images/sampah_3.png',
                          'assets/images/sampah_4.png',
                          'assets/images/sampah_5.png',
                        ],
                        description:
                            'Tempat sampah berwarna hijau yang digunakan untuk menampung sampah organik (sampah yang mudah terurai secara alami)',
                        examples:
                            'Tempat sampah ini cocok digunakan untuk membuang sampah-sampah seperti: sisa makanan, daun&ranting, kulit buah, dan sayuran',
                      ),

                      const SizedBox(height: 40),
                      _buildDivider(),
                      const SizedBox(height: 40),

                      _buildWasteTypeSection(
                        context: context,
                        title: 'Sampah Anorganik',
                        mainImage: 'assets/images/sampah_2.png',
                        mainImageWidth: screenWidth * 0.47, // 194/412 ≈ 0.47
                        mainImageHeight: 129,
                        exampleImages: [
                          'assets/images/sampah_3.png',
                          'assets/images/sampah_4.png',
                          'assets/images/sampah_5.png',
                        ],
                        description:
                            'Tempat sampah berwarna kuning sebagai tempat untuk menampung sampah anorganik. Sampah ini tidak mudah terurai seperti sampah organik, namun sampah ini bisa untuk didaur ulang menjadi bahan baru sehingga dapat mengurangi limbah.',
                        examples:
                            'Tempat sampah ini cocok digunakan untuk membuang sampah-sampah seperti: botol plastik, kaleng, kertas & kardus, kemasan makanan',
                      ),

                      const SizedBox(height: 40),
                      _buildDivider(),
                      const SizedBox(height: 40),

                      _buildWasteTypeSection(
                        context: context,
                        title: 'Sampah B3',
                        mainImage: 'assets/images/sampah_1.png',
                        mainImageWidth: screenWidth * 0.36, // 148/412 ≈ 0.36
                        mainImageHeight: 178,
                        exampleImages: [
                          'assets/images/sampah_3.png',
                          'assets/images/sampah_4.png',
                          'assets/images/sampah_5.png',
                        ],
                        description:
                            'Sampah B3 merupakan sampah jenis elektronik dan bisa juga berbahaya',
                        examples:
                            'Tempat sampah dengan warna merah ini cocok digunakan untuk membuang sampah-sampah elektronik seperti: baterai, lampu, obat kadaluwarsa, dan perangkat elektronik yang sudah rusak.',
                        isB3: true,
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

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD1D1D1),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildWasteTypeSection({
    required BuildContext context,
    required String title,
    required String mainImage,
    required double mainImageWidth,
    required double mainImageHeight,
    required List<String> exampleImages,
    required String description,
    required String examples,
    bool isB3 = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          // Content
          Column(
            children: [
              // Main Image and Example Images
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    // Main Image
                    Container(
                      width: mainImageWidth,
                      height: mainImageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(mainImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Example Images Row
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: exampleImages.map((imagePath) {
                          return Container(
                            width: screenWidth * 0.21, // 88/412 ≈ 0.21
                            height: 59,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Description and Examples
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Color(0xFF565656),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    examples,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Color(0xFF565656),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
