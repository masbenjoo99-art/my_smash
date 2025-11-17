import 'package:flutter/material.dart';
import 'package:my_smash/widgets/app_bar.dart';
import 'package:my_smash/widgets/bottom_nav_bar.dart';

class EditProfilNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Name
            Text(
              'Ahmad Usamah Ali',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            
            // Profile Picture with Edit Button
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/foto_profil.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D77BB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Profile Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFC6F8FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildProfileField(
                    label: 'Nama Lengkap',
                    value: 'Ahmad Usamah Ali',
                  ),
                  const SizedBox(height: 14),
                  _buildProfileField(
                    label: 'Email',
                    value: 'Ahmadusao@gmail.com',
                  ),
                  const SizedBox(height: 14),
                  _buildProfileField(
                    label: 'Nomor Telepon',
                    value: '08525524526',
                  ),
                  const SizedBox(height: 14),
                  _buildProfileField(
                    label: 'Password',
                    value: '**************',
                    isPassword: true,
                  ),
                  const SizedBox(height: 14),
                  _buildProfileField(
                    label: 'Alamat',
                    value: 'Jl. Yasmin, No. 32. Kota Bogor, Prov. Jawabarat',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Save Button
            SizedBox(
              width: 221,
              height: 59,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF216BC2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Simpan Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3), // Education index
    );
  }

  Widget _buildProfileField({
    required String label,
    required String value,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF5B5252),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: const Color(0xFF5B5252),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

}