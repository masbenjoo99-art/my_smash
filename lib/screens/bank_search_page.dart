import 'package:flutter/material.dart';
import 'package:my_smash/widgets/app_bar.dart';
import 'package:my_smash/widgets/bottom_nav_bar.dart';
import 'package:my_smash/banksampah/bank_search_screen.dart';

class BankSearchPage extends StatelessWidget {
  const BankSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const SafeArea(
        child: BankSearchScreen(), // <-- ini sekarang sudah ketemu
      ),
      // karena ini dipanggil dari menu History, index-nya samakan dengan History
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}
