import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/database_helper.dart';

class KategoriHargaScreen extends StatefulWidget {
  final Map<String, dynamic> bankSampah;

  const KategoriHargaScreen({super.key, required this.bankSampah});

  @override
  State<KategoriHargaScreen> createState() => _KategoriHargaScreenState();
}

class _KategoriHargaScreenState extends State<KategoriHargaScreen> {
  List<Map<String, dynamic>> _kategoriList = [];
  bool _loading = true;
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _loadKategoriSampah();
  }

  Future<void> _loadKategoriSampah() async {
    try {
      final kategoriData = await DatabaseHelper.instance
          .getKategoriSampahByBankId(widget.bankSampah['id']);
      
      // Hanya seed untuk Bank Sampah Akar Rumput Janti (ID=1)
      if (kategoriData.isEmpty && widget.bankSampah['id'] == 1) {
        await DatabaseHelper.instance.seedKategoriSampah(widget.bankSampah['id']);
        final newData = await DatabaseHelper.instance
            .getKategoriSampahByBankId(widget.bankSampah['id']);
        setState(() {
          _kategoriList = newData;
          _loading = false;
        });
      } else {
        setState(() {
          _kategoriList = kategoriData;
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading kategori sampah: $e");
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Kategori & Harga Sampah',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2196F3),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildContent()),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.bankSampah['nama'] ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Terakhir diperbaharui: 26 July 2019\n12:31:56',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // Tampilkan pesan untuk bank selain Akar Rumput Janti
    if (widget.bankSampah['id'] != 1) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline,
                size: 64,
                color: Colors.blue[300],
              ),
              const SizedBox(height: 16),
              const Text(
                'Informasi Kategori & Harga',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Data kategori dan harga sampah untuk ${widget.bankSampah['nama']} belum tersedia.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Silakan hubungi bank sampah langsung untuk informasi harga terkini.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, size: 16, color: Colors.green[600]),
                  const SizedBox(width: 8),
                  Text(
                    widget.bankSampah['kontak'] ?? 'Kontak tidak tersedia',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Tampilan normal untuk Bank Sampah Akar Rumput Janti
    if (_kategoriList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Belum ada data kategori sampah',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Kategori',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Harga',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          
          // Table content
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _kategoriList.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey[200],
              ),
              itemBuilder: (context, index) {
                final kategori = _kategoriList[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          kategori['nama_kategori'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${_currencyFormat.format(kategori['harga_per_kg'])}/${kategori['satuan']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
