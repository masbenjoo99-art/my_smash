import 'package:flutter/material.dart';
import 'search_bar.dart' as my_widgets;

class WasteLocationCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onSearch;

  /// asset icon kuning di bagian bawah (berbeda untuk setiap card)
  final String footerAssetPath;

  const WasteLocationCard({
    super.key,
    required this.title,
    required this.description,
    required this.onSearch,
    required this.footerAssetPath,
  });

  String get _getHintText {
    if (title.toLowerCase().contains('smart drop box')) {
      return 'Cari Smart Drop Box...';
    }
    return 'Cari Bank Sampah...';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
          children: [
            // TITLE
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            // DESCRIPTION
            Text(
              description,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),

            // SEARCH BAR
            my_widgets.SearchBar(
              hintText: _getHintText,
              onTap: onSearch,
            ),
            const SizedBox(height: 16),

            // ICON + TEXT “Kamu bisa mencari…”
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  footerAssetPath,
                  width: 56,
                  height: 56,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Kamu bisa mencari dimanapun dan kapanpun!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
