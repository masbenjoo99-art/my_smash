import 'package:flutter/material.dart';
import 'package:my_smash/diskusi/discussion.dart';
import 'package:my_smash/diskusi/notifikasi.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF216BC2),
      elevation: 2,

      // penting: supaya tidak muncul tombol back otomatis
      automaticallyImplyLeading: false,

      // ---------- LOGO ----------
      title: SizedBox(
        height: 36,
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      ),

      // ---------- ACTIONS ----------
      actions: [
        // Forum Diskusi (gambar baru)
        IconButton(
          tooltip: 'Forum Diskusi',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Discussion9()),
            );
          },
          icon: Image.asset(
            'assets/images/coment.png', 
            width: 30,
            height: 30,
            color: Colors.white,   
          ),
        ),

        const SizedBox(width: 4),
      ],
    );
  }
}
