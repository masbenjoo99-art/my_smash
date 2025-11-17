import 'package:flutter/material.dart';
import 'search_bar.dart' as my_widgets;

class WasteLocationCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onSearch;
  
  const WasteLocationCard({
    super.key,
    required this.title,
    required this.description,
    required this.onSearch,
  });

  // ✅ DYNAMIC: Generate hint text based on title
  String get _getHintText {
    if (title.toLowerCase().contains('smart drop box')) {
      return 'Cari Smart Drop Box...';
    } else {
      return 'Cari Bank Sampah...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),
            my_widgets.SearchBar(
              hintText: _getHintText, // ✅ DYNAMIC hint text
              onTap: onSearch, // ✅ GUNAKAN callback parameter
            ),
            const SizedBox(height: 16),
            const Text(
              'Kamu bisa mencari dimanapun dan kapanpun!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
