import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import 'bank_detail_screen.dart';
import '../screens/bank_map_screen.dart';

class BankListScreen extends StatelessWidget {
  final String city;
  final List<Map<String, dynamic>> banks;

  const BankListScreen({super.key, required this.city, required this.banks});

  static Future<BankListScreen> create(String city) async {
    // Ambil data dari DB
    final rows = await DatabaseHelper.instance.getAllBankSampah();

    debugPrint("📌 Jumlah rows dari DB: ${rows.length}");
    for (var r in rows) {
      debugPrint("➡️ ${r['nama']} | ${r['alamat']}");
    }

    return BankListScreen(city: city, banks: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Sampah di $city"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BankMapScreen(selectedBanks: banks)),
              );
            },
          ),
        ],
      ),
      body: banks.isEmpty
          ? const Center(child: Text("Tidak ada data"))
          : ListView.separated(
              itemCount: banks.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final bank = banks[index];
                return ListTile(
                  leading: const Icon(Icons.recycling, color: Colors.green),
                  title: Text(
                    bank['nama'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(bank['alamat']),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BankDetailScreen(bank: bank),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
