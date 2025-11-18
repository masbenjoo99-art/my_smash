import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../banksampah/bank_search_screen.dart';

class BankSearchPage extends StatelessWidget {
  const BankSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF216BC2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: 32,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔵 BANNER
            Container(
              margin: const EdgeInsets.all(16),
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

            // 🔵 CARD PUTIH BESAR
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
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

                  // 🔍 SEARCH & LIST — dari BankSearchScreen
                  SizedBox(
                    height: 520,
                    child: BankSearchScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
