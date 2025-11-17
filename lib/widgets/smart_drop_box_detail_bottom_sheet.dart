import 'package:flutter/material.dart';

class SmartDropBoxDetailBottomSheet extends StatelessWidget {
  final Map<String, dynamic> sdb;

  const SmartDropBoxDetailBottomSheet({super.key, required this.sdb});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            // Title
            Text(
              sdb['nama'] ?? 'Smart Drop Box',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              sdb['lokasi'] ?? '-',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const Divider(height: 24),

            // Info rows
            _buildInfoRow(Icons.location_city, "Kota", sdb['city']),
            _buildInfoRow(Icons.check_circle, "Status", sdb['status']),
            _buildInfoRow(Icons.recycling, "Jenis Sampah", sdb['jenis_sampah']),
            _buildInfoRow(
              Icons.card_giftcard,
              "Reward",
              (sdb['reward_per_item'] != null && sdb['reward_per_item'] != 0)
                  ? "${sdb['reward_per_item']} poin / item"
                  : "-",
            ),
            _buildInfoRow(Icons.access_time, "Jam Operasional", sdb['jam_operasional']),
            _buildInfoRow(Icons.qr_code, "Kode QR", sdb['qr_code']),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text(
                  "Lihat di Peta",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // tutup modal
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$label: ",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: (value?.toString().isNotEmpty ?? false) ? value.toString() : "-",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
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
