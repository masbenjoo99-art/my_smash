import 'package:flutter/material.dart';
import 'package:my_smash/widgets/app_bar.dart';
import 'package:my_smash/widgets/bottom_nav_bar.dart';
import 'package:my_smash/profile/edit_profil.dart'; // Import halaman edit profil

class ProfilAfter1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmad Usamah ALi',
                        style: TextStyle(
                          color: const Color(0xFF222227),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ahmadusa@gmail.com',
                        style: TextStyle(
                          color: const Color(0xFF222227),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: 115,
                      height: 125,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/images/foto_profil.png"),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D77BB),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Profile Sections
            _buildProfileSection('Bank Sampah'),
            const SizedBox(height: 20),
            
            // Stats Cards
            _buildStatsCard(
              title: 'Berat Sampah',
              value: '0 Kg',
            ),
            const SizedBox(height: 20),
            
            _buildStatsCard(
              title: 'Saldo Tunai',
              value: 'Rp.0,-',
            ),
            const SizedBox(height: 20),
            
            _buildStatsCard(
              title: 'Konversi Sampah Botol',
              value: 'Rp.0,-',
            ),
            const SizedBox(height: 20),
            
            _buildStatsCard(
              title: 'Versi App',
              value: '4.0.4.1901228.1v',
            ),
            const SizedBox(height: 20),

            // Action Buttons
            _buildActionButton(
              'Edit Profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilNew()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildActionButton('Logout', isImportant: true),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3), // Education index
    );
  }

  Widget _buildProfileSection(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFF3D77BB),
          width: 1,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF222227),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatsCard({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFF3D77BB),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF222227),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF222227),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, {bool isImportant = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isImportant ? Colors.red[50] : const Color(0xFFF4F7F5),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isImportant ? Colors.red : const Color(0xFF3D77BB),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isImportant ? Colors.red : const Color(0xFF222227),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}