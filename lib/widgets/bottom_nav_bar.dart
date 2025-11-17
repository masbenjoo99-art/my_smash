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
      case 0:                         // Home
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        break;

      case 1:                         // History
        Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen()));
        break;

      // index 2 = Scan SDB  →  sengaja dikosongkan (statis)

      case 3:                         // Education
        Navigator.push(context, MaterialPageRoute(builder: (_) => EducationScreen()));
        break;

      case 4:                         // Profile
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilAfter1()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF053C7D),
      unselectedItemColor: const Color(0xFF646965),
      onTap: (idx) => _onItemTapped(context, idx),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.history_rounded),
          label: 'History',
        ),

        // ----------  Scan SDB (statis) ----------
        BottomNavigationBarItem(
          label: 'Scan SDB',
          tooltip: 'Scan Smart Drop Box',
          icon: Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFF216BC2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.qr_code_2, size: 28, color: Colors.white),
          ),
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          label: 'Education',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
