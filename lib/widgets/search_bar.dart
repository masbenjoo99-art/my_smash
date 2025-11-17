import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;
  
  const SearchBar({
    super.key,
    required this.hintText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF376397)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFFB5B5B6)),
            const SizedBox(width: 16),
            Text(
              hintText,
              style: const TextStyle(
                color: Color(0xFFB5B5B6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}