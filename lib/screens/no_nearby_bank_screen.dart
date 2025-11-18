// lib/banksampah/no_nearby_bank_screen.dart
import 'package:flutter/material.dart';

class NoNearbyBankScreen extends StatelessWidget {
  final String city;

  const NoNearbyBankScreen({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF216BC2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: 32,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// === Ilustrasi lokasi (lingkaran biru + pin putih) ===
                const _FluentMdl2LocationFill(),

                const SizedBox(height: 32),

                const Text(
                  'Tidak ada hasil untuk lokasi di sekitar anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Belum ada Bank Sampah yang terdaftar di sekitar kota $city.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// =======================================================
///  WIDGET ILUSTRASI – LINGKARAN BIRU + IKON LOKASI PUTIH
/// (DILETAKKAN DALAM FILE YANG SAMA SESUAI PERMINTAAN)
/// =======================================================
class _FluentMdl2LocationFill extends StatelessWidget {
  const _FluentMdl2LocationFill({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 204,
      height: 204,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lingkaran biru
          Container(
            width: 204,
            height: 204,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0096FF),
            ),
          ),

          // Ikon lokasi putih
          Image.asset(
            'assets/images/location_white.png', 
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
