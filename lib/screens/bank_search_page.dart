import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../banksampah/bank_search_screen.dart';

class BankSearchPage extends StatelessWidget {
  const BankSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔵 APP BAR ATAS
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
        centerTitle: false,
      ),

      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // 🔵 BANNER
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/banner1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔵 CARD PUTIH BESAR (ISI BISA SCROLL DI DALAMNYA)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bank Sampah",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Cari bank sampah di sekitarmu!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 👉 ISI: SEARCH + LIST (dari BankSearchScreen)
                    const Expanded(
                      child: BankSearchScreen(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
