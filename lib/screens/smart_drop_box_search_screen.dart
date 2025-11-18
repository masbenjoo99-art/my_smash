import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../db/database_helper.dart';
import 'smart_drop_box_map_screen.dart';
import 'no_nearby_bank_screen.dart';


class SmartDropBoxSearchScreen extends StatefulWidget {
  const SmartDropBoxSearchScreen({super.key});

  @override
  State<SmartDropBoxSearchScreen> createState() =>
      _SmartDropBoxSearchScreenState();
}

class _SmartDropBoxSearchScreenState extends State<SmartDropBoxSearchScreen> {
  List<Map<String, dynamic>> _allDropBoxes = [];
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
    try {
      final dbCities = await DatabaseHelper.instance.getSmartDropBoxCities();
      final dropBoxes = await DatabaseHelper.instance.getAllSmartDropBox();

      final extraCities = [
        'Ambon',
        'Balikpapan',
        'Banjarmasin',
        'Banjarbaru',
        'Batam',
        'Bekasi',
        'Bandung',
        'Bali',
        'Bogor',
        'Cirebon',
        'Denpasar',
        'Jakarta',
        'Malang',
        'Manado',
        'Medan',
        'Palembang',
        'Pontianak',
        'Semarang',
        'Surabaya',
        'Tangerang',
        'Depok',
        'Makassar',
        'Padang',
        'Pekanbaru',
        'Samarinda',
        'Jambi',
        'Kendari',
        'Mataram',
        'Jayapura',
        'Kupang',
        'Ternate',
        'Bengkulu',
        'yogyakarta',
      ];

      final allCities = {...dbCities, ...extraCities}.toList();
      allCities.sort();

      if (!mounted) return;
      setState(() {
        _cities = allCities;
        _filteredCities = allCities;
        _allDropBoxes = dropBoxes;
        _searchResults = dropBoxes;
        _loading = false;
      });
    } catch (e) {
      debugPrint("❌ Error loading Smart Drop Box data: $e");
      if (!mounted) return;
      setState(() => _loading = false);
    }
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
        _searchResults = _allDropBoxes;
      });
      return;
    }

    _performSearch(query);
  }

  Future<void> _performSearch(String query) async {
    try {
      final searchResults =
          await DatabaseHelper.instance.searchSmartDropBox(query);
      final cityResults =
          await DatabaseHelper.instance.searchSmartDropBoxCities(query);

      final filteredCities = cityResults.isNotEmpty
          ? cityResults
          : _cities
              .where((city) =>
                  city.toLowerCase().contains(query.toLowerCase()))
              .toList();

      if (!mounted) return;
      setState(() {
        _searchResults = searchResults;
        _filteredCities = filteredCities;
      });
    } catch (e) {
      debugPrint("❌ Error searching Smart Drop Box: $e");
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearchActive = false;
      _searchQuery = '';
      _filteredCities = _cities;
      _searchResults = _allDropBoxes;
    });
  }

  // contoh: gunakan semua SDB Bandung sebagai "lokasi saat ini"
  void _useCurrentLocation() async {
    try {
      final bandungDropBoxes =
          await DatabaseHelper.instance.getSmartDropBoxByCity('Bandung');

      if (!mounted) return;

      if (bandungDropBoxes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Belum ada Smart Drop Box di area ini")),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              SmartDropBoxMapScreen(selectedSDB: bandungDropBoxes),
        ),
      );
    } catch (e) {
      debugPrint("❌ Error showing Bandung drop boxes: $e");
    }
  }

  void _showSDBList(
      BuildContext context, String city, List<Map<String, dynamic>> sdbs) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.smart_toy, color: Colors.orange, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Smart Drop Box di $city',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (sdbs.isEmpty)
                Column(
                  children: [
                    const Icon(Icons.smart_toy,
                        size: 48, color: Colors.grey),
                    const SizedBox(height: 8),
                    const Text("Belum ada Smart Drop Box untuk kota ini"),
                    const SizedBox(height: 8),
                    if (city.toLowerCase() == 'bandung')
                      const Text(
                        "💡 Info: Kota Bandung memiliki Smart Drop Box dari program Desa Digital",
                        style:
                            TextStyle(fontSize: 12, color: Colors.orange),
                        textAlign: TextAlign.center,
                      ),
                  ],
                )
              else
                // ✅ FIX: Jangan pakai Flexible/Expanded di mainAxisSize.min
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: sdbs.length,
                    itemBuilder: (context, index) {
                      final sdb = sdbs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.smart_toy,
                              color: Colors.orange),
                          title: Text(sdb['nama'] ?? '-'),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(sdb['lokasi'] ?? '-'),
                              Text('Jenis: ${sdb['jenis_sampah'] ?? '-'}'),
                              Text(
                                  'Reward: Rp ${sdb['reward_per_item'] ?? 0}/item'),
                              Text(
                                  'Jam: ${sdb['jam_operasional'] ?? '-'}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              if (sdbs.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SmartDropBoxMapScreen(selectedSDB: sdbs),
                        ),
                      );
                    },
                    child: const Text('Lihat di Peta',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                children: [
                  const SizedBox(height: 16),
                  _buildBanner(),
                  const SizedBox(height: 16),
                  _buildCardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderTexts(),
                        const SizedBox(height: 16),
                        _buildSearchField(),
                        const SizedBox(height: 16),
                        _buildSearchResults(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLocationButton(),
                ],
              ),
      ),
    );
  }

  // ---------- UI BUILDERS ----------

  Widget _buildBanner() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/banner1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 6,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildHeaderTexts() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Smart Drop Box',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF222227),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Cari smart drop box di sekitarmu!',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF707070),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Semua Lokasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF222227),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Cari lokasi atau Smart Drop Box...',
        prefixIcon: const Icon(Icons.search, color: Color(0xFFB5B5B6)),
        suffixIcon: _isSearchActive
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: _clearSearch,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF376397)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF216BC2)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  Widget _buildLocationButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF216BC2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        icon: const Icon(Icons.my_location, color: Colors.white),
        onPressed: _useCurrentLocation,
        label: const Text(
          'Gunakan Lokasi Saat Ini',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600),
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
    final hasDropBoxResults = _searchResults.isNotEmpty;

    if (!hasCityResults && !hasDropBoxResults) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Icon(Icons.smart_toy, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('Tidak ditemukan Smart Drop Box',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            Text('Coba kata kunci yang berbeda',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasCityResults) ...[
          _buildSectionHeader(
              'Kota (${_filteredCities.length})', Icons.location_city),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredCities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) =>
                _buildCityTile(_filteredCities[index]),
          ),
          const SizedBox(height: 16),
        ],
        if (hasDropBoxResults) ...[
          _buildSectionHeader(
              'Smart Drop Box (${_searchResults.length})', Icons.smart_toy),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _searchResults.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) =>
                _buildDropBoxTile(_searchResults[index]),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3D77BB), size: 18),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222227),
          ),
        ),
      ],
    );
  }

  Widget _buildCityList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _cities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _buildCityTile(_cities[index]),
    );
  }

  Widget _buildCityTile(String city) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        final sdbs =
            await DatabaseHelper.instance.getSmartDropBoxByCity(city);
        if (!context.mounted) return;
        _showSDBList(context, city, sdbs);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF3D77BB)),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on,
                color: Color(0xFF3D77BB), size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                city,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF222227),
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildDropBoxTile(Map<String, dynamic> dropBox) {
    return InkWell(
      onTap: () {
        final city = dropBox['city'] ?? '';
        _showSDBList(context, city, [dropBox]);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            const Icon(Icons.smart_toy, color: Colors.orange),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dropBox['nama'] ?? '-',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dropBox['lokasi'] ?? '-',
                    style: const TextStyle(
                        fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Reward: Rp ${dropBox['reward_per_item'] ?? 0}/item • ${dropBox['status'] ?? '-'}',
                    style: const TextStyle(
                        fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dropBox['city'] ?? '',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3D77BB),
                  ),
                ),
                const SizedBox(height: 4),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
