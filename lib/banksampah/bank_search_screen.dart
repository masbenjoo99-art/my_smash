import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../screens/bank_map_screen.dart';
import '../screens/bank_detail_screen.dart';

class BankSearchScreen extends StatefulWidget {
  const BankSearchScreen({super.key});

  @override
  State<BankSearchScreen> createState() => _BankSearchScreenState();
}

class _BankSearchScreenState extends State<BankSearchScreen> {
  List<Map<String, dynamic>> _allBanks = [];
  List<Map<String, dynamic>> _searchResults = [];
  List<String> _cities = [];
  List<String> _filteredCities = [];
  
  final TextEditingController _searchController = TextEditingController();
  bool _loading = true;
  bool _isSearchActive = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final dbCities = await DatabaseHelper.instance.getBankSampahCities();
    final banks = await DatabaseHelper.instance.getAllBankSampah();

    final extraCities = [
      'Ambon', 'Bali', 'Balikpapan', 'Bandung', 'Banjarbaru', 
      'Banjarmasin', 'Batam', 'Baubau', 'Bekasi', 'Bengkulu',
      'Bogor', 'Cirebon', 'Denpasar', 'Gorontalo', 'Jakarta', 
      'Jambi', 'Jayapura', 'Kendari', 'Kupang', 'Malang', 
      'Manado', 'Mataram', 'Medan', 'Padang', 'Palembang', 
      'Palu', 'Pontianak', 'Samarinda', 'Semarang', 'Surabaya', 
      'Ternate',
    ];

    final allCities = {...dbCities, ...extraCities}.toList();
    allCities.sort();

    if (!mounted) return;
    setState(() {
      _cities = allCities;
      _filteredCities = allCities;
      _allBanks = banks;
      _searchResults = banks;
      _loading = false;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      _searchQuery = query;
      _isSearchActive = query.isNotEmpty;
    });

    if (query.isEmpty) {
      setState(() {
        _filteredCities = _cities;
        _searchResults = _allBanks;
      });
      return;
    }

    _performSearch(query);
  }

  Future<void> _performSearch(String query) async {
    final searchResults = await DatabaseHelper.instance.searchBankSampah(query);
    final cityResults = await DatabaseHelper.instance.searchBankSampahCities(query);

    final filteredCities = cityResults.isNotEmpty 
        ? cityResults 
        : _cities.where((city) => city.toLowerCase().contains(query.toLowerCase())).toList();

    if (!mounted) return;
    setState(() {
      _searchResults = searchResults;
      _filteredCities = filteredCities;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearchActive = false;
      _searchQuery = '';
      _filteredCities = _cities;
      _searchResults = _allBanks;
    });
  }

  void _showAllYogyakartaBanks() async {
    final yogyaBanks = await DatabaseHelper.instance.getBanksByCity('Yogyakarta');
    
    if (!mounted) return;
    
    if (yogyaBanks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Belum ada Bank Sampah di area ini")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BankMapScreen(selectedBanks: yogyaBanks),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Hanya konten, TIDAK pakai Scaffold di sini
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              _buildHeader(),
              _buildSearchField(),
              const SizedBox(height: 16),
              _buildLocationButton(),
              const SizedBox(height: 16),
              Expanded(child: _buildSearchResults()),
            ],
          );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cari Bank Sampah di sekitarmu!',
            style: TextStyle(fontSize: 16, color: Color(0xFF222227)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  _isSearchActive 
                      ? 'Hasil Pencarian "$_searchQuery"' 
                      : 'Semua Lokasi Bank Sampah',
                  style: const TextStyle(
                    fontSize: 20, 
                    color: Color(0xFF222227), 
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (_isSearchActive) ...[
                TextButton(
                  onPressed: _clearSearch,
                  child: const Text('Clear', style: TextStyle(color: Colors.red)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari Bank Sampah atau kota...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFFB5B5B6)),
          suffixIcon: _isSearchActive
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: _clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xFF376397)),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildLocationButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF216BC2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: _showAllYogyakartaBanks,
          child: const Text(
            'Gunakan Lokasi Saat Ini',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearchActive) {
      return _buildActiveSearchResults();
    } else {
      return _buildCityList();
    }
  }

  Widget _buildActiveSearchResults() {
    final hasCityResults = _filteredCities.isNotEmpty;
    final hasBankResults = _searchResults.isNotEmpty;

    if (!hasCityResults && !hasBankResults) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Tidak ditemukan Bank Sampah',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              'Coba kata kunci yang berbeda',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasCityResults) ...[
            _buildSectionHeader('Kota (${_filteredCities.length})', Icons.location_city),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredCities.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final city = _filteredCities[index];
                return _buildCityTile(city);
              },
            ),
            const SizedBox(height: 24),
          ],

          if (hasBankResults) ...[
            _buildSectionHeader('Bank Sampah (${_searchResults.length})', Icons.recycling),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final bank = _searchResults[index];
                return _buildBankTile(bank);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3D77BB), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222227),
          ),
        ),
      ],
    );
  }

  Widget _buildCityList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemCount: _filteredCities.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final city = _filteredCities[index];
          return _buildCityTile(city);
        },
      ),
    );
  }

  Widget _buildCityTile(String city) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Color(0xFF3D77BB)),
      title: Text(
        city,
        style: const TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.w600, 
          color: Color(0xFF222227),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () => _showBankDetails(city),
    );
  }

  Widget _buildBankTile(Map<String, dynamic> bank) {
    return ListTile(
      leading: const Icon(Icons.recycling, color: Colors.green),
      title: Text(
        bank['nama'],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bank['alamat']),
          if (bank['penanggung_jawab'] != null)
            Text(
              'PJ: ${bank['penanggung_jawab']}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            bank['city'],
            style: const TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.w500, 
              color: Color(0xFF3D77BB),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankDetailScreen(bank: bank),
          ),
        );
      },
    );
  }

  void _showBankDetails(String city) async {
    final banks = await DatabaseHelper.instance.getBanksByCity(city);

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bank Sampah di $city', 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (banks.isEmpty)
                const Text("Belum ada Bank Sampah untuk kota ini")
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: banks.length,
                    itemBuilder: (_, i) {
                      final bank = banks[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(bank['nama']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(bank['alamat']),
                              if (bank['penanggung_jawab'] != null)
                                Text('PJ: ${bank['penanggung_jawab']}'),
                              const Text('Jam Operasional: 08:00 - 17:00'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              if (banks.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BankMapScreen(selectedBanks: banks),
                        ),
                      );
                    },
                    child: const Text('Lihat di Peta'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
