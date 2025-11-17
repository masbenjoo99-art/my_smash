import 'package:flutter/material.dart';
import '../screens/kategori_harga_screen.dart'; // ✅ TAMBAH IMPORT INI

class BankDetailBottomSheet extends StatelessWidget {
  final Map<String, dynamic> bank;

  const BankDetailBottomSheet({super.key, required this.bank});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // ✅ Responsive height: Desktop vs Mobile
    final isDesktop = screenWidth > 800;
    final maxHeight = isDesktop ? screenHeight * 0.8 : screenHeight * 0.7;
    final minHeight = screenHeight * 0.4;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: minHeight < 300 ? 300 : minHeight, // Minimum 300px
        maxWidth: isDesktop ? 600 : double.infinity, // Batasi lebar di desktop
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ Important: gunakan min
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // ✅ Scrollable content
            Flexible( // Ganti Expanded dengan Flexible
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title dengan responsive font
                    Text(
                      bank['nama'] ?? '',
                      style: TextStyle(
                        fontSize: isDesktop ? 18 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Info rows dengan spacing yang lebih kecil
                    _buildInfoRow(context, Icons.person, 'Penanggung Jawab', bank['penanggung_jawab'] ?? '-'),
                    _buildInfoRow(context, Icons.phone, 'Kontak', bank['kontak'] ?? '-'),
                    _buildInfoRow(context, Icons.email, 'Email', bank['email'] ?? '-'),
                    _buildInfoRow(context, Icons.people, 'Jumlah Nasabah', '${bank['jumlah_nasabah'] ?? 0}'),
                    _buildInfoRow(context, Icons.category, 'Jumlah Kategori Sampah', '${bank['jumlah_kategori'] ?? 0}'),
                    _buildInfoRow(context, Icons.location_on, 'Alamat', bank['alamat'] ?? '-'),
                    
                    const SizedBox(height: 16),
                    
                    // Action Buttons
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon, 
            size: isDesktop ? 18 : 16, 
            color: Colors.grey[600]
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label : ',
                  style: TextStyle(
                    fontSize: isDesktop ? 13 : 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 12 : 10),
            ),
            onPressed: () {
              // ✅ UPDATE: Navigate ke kategori harga screen
              Navigator.pop(context); // Tutup bottom sheet dulu
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => KategoriHargaScreen(bankSampah: bank),
                ),
              );
            },
            child: Text(
              'Kategori & Harga Sampah',
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: isDesktop ? 14 : 13,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF216BC2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 12 : 10),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Permintaan Menjadi Nasabah')),
              );
            },
            child: Text(
              'Permintaan Menjadi Nasabah',
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: isDesktop ? 14 : 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
