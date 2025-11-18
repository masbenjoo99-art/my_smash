import 'package:flutter/material.dart';

class WasteCategoriesGrid extends StatelessWidget {
  const WasteCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Kertas/Koran', 'iconPath': 'assets/images/koran.png'},
      {
        'name': 'Kaleng makanan/\nMinuman',
        'iconPath': 'assets/images/kaleng.png'
      },
      {'name': 'Sisa Makanan', 'iconPath': 'assets/images/sisa_makanan.png'},
    ];

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // ukuran icon menyesuaikan lebar card
            final double iconSize = constraints.maxWidth / 3; // kira-kira pas di 3 kolom

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((category) {
                return Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: iconSize,
                        child: Image.asset(
                          category['iconPath']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        category['name']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
