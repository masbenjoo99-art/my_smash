import 'package:flutter/material.dart';

class WasteCategoriesGrid extends StatelessWidget {
  const WasteCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Kertas/Koran', 'iconPath': 'assets/images/koran.png'},
      {'name': 'Kaleng makanan/Minuman', 'iconPath': 'assets/images/kaleng.png'},
      {'name': 'Sisa Makanan', 'iconPath': 'assets/images/sisa_makanan.png'},
      // Tambahkan kategori lainnya jika diperlukan
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return Column(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                category['iconPath']!,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category['name']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
