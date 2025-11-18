import 'package:flutter/material.dart';
import 'package:my_smash/education/education1.dart';
import 'package:my_smash/profile/profilafter1.dart';
import 'package:my_smash/screens/home_screen.dart';
import '../history/history_screens.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  const BottomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0: // Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;

      case 1: // History
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HistoryScreen()),
        );
        break;

      case 2: // Scan SDB (isi sesuai kebutuhanmu)
        // TODO: arahkan ke halaman Scan SDB
        break;

      case 3: // Education
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EducationScreen()),
        );
        break;

      case 4: // Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProfilAfter1()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // tinggi total: bar + tombol bulat yang “mengambang”
    return SizedBox(
      height: 60,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ---------- LAYER: BACKGROUND BAR ----------
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F7F5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // HOME
                  _NavItem(
                    index: 0,
                    selectedIndex: selectedIndex,
                    label: 'Home',
                    assetPath: 'assets/images/home_nav.png',
                    onTap: () => _onItemTapped(context, 0),
                  ),

                  // HISTORY
                  _NavItem(
                    index: 1,
                    selectedIndex: selectedIndex,
                    label: 'History',
                    assetPath: 'assets/images/history_nav.png',
                    onTap: () => _onItemTapped(context, 1),
                  ),

                  // SPACE di bawah tombol Scan SDB
                  const Expanded(child: SizedBox()),

                  // EDUCATION
                  _NavItem(
                    index: 3,
                    selectedIndex: selectedIndex,
                    label: 'Education',
                    assetPath: 'assets/images/edu_nav.png',
                    onTap: () => _onItemTapped(context, 3),
                  ),

                  // PROFILE
                  _NavItem(
                    index: 4,
                    selectedIndex: selectedIndex,
                    label: 'Profile',
                    assetPath: 'assets/images/profil_nav.png',
                    onTap: () => _onItemTapped(context, 4),
                  ),
                ],
              ),
            ),
          ),

          // ---------- LAYER: TOMBOL SCAN SDB MENGAMBANG ----------
          Positioned(
            left: 0,
            right: 0,
            bottom: 7,
            child: GestureDetector(
              onTap: () => _onItemTapped(context, 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF216BC2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 32,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/scan_nav.png',
                        width: 32,
                        height: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Scan SDB',
                    style: TextStyle(
                      color: Color(0xFF646965),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- WIDGET ITEM NAV ----------
class _NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String label;
  final String assetPath;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                assetPath,
                width: 26,
                height: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF053C7D)
                      : const Color(0xFF646965),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
