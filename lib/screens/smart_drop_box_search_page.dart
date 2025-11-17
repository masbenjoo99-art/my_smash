import 'package:flutter/material.dart';
import 'package:my_smash/widgets/app_bar.dart';
import 'package:my_smash/widgets/bottom_nav_bar.dart';
import 'package:my_smash/screens/smart_drop_box_search_screen.dart';

class SmartDropBoxSearchPage extends StatelessWidget {
  const SmartDropBoxSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
      body: const SafeArea(
        child: SmartDropBoxSearchScreen(),
      ),
    );
  }
}
