import 'package:flutter/material.dart';

class SmartDropBoxSearchScreen extends StatelessWidget {
  const SmartDropBoxSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Cari Smart Drop Box di sekitarmu!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF222227),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Semua Lokasi Smart Drop Box',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF222227),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Nanti di sini bisa ditambah TextField & list hasil search
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.location_searching, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Halaman pencarian Smart Drop Box',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
