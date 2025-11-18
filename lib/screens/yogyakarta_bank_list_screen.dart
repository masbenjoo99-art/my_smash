import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../screens/bank_map_screen.dart';

class YogyakartaBankListScreen extends StatefulWidget {
  const YogyakartaBankListScreen({super.key});

  @override
  State<YogyakartaBankListScreen> createState() => _YogyakartaBankListScreenState();
}

class _YogyakartaBankListScreenState extends State<YogyakartaBankListScreen> {
  List<Map<String, dynamic>> _banks = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadYogyaBanks();
  }

  Future<void> _loadYogyaBanks() async {
    final data = await DatabaseHelper.instance.getBanksByCity('Yogyakarta');

    setState(() {
      _banks = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF216BC2),
        title: const Text(
          "Bank Sampah - Yogyakarta",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _banks.isEmpty
              ? const Center(
                  child: Text(
                    "Belum ada Bank Sampah di Yogyakarta",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: _banks.length,
                  itemBuilder: (_, index) {
                    final bank = _banks[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BankMapScreen(selectedBanks: [bank]),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bank['nama'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    bank['alamat'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
