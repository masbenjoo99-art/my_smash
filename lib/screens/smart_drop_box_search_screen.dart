import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../db/database_helper.dart';
import 'smart_drop_box_map_screen.dart';

class SmartDropBoxSearchScreen extends StatefulWidget {
  const SmartDropBoxSearchScreen({super.key});

  @override
  State<SmartDropBoxSearchScreen> createState() => _SmartDropBoxSearchScreenState();
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
      // ✅ HANYA SMART DROP BOX: Load dari database
      final dbCities = await DatabaseHelper.instance.getSmartDropBoxCities();
      final dropBoxes = await DatabaseHelper.instance.getAllSmartDropBox();

      // ✅ SMART DROP BOX: Extra cities demo 
      final extraCities = [
        'Balikpapan', 'Banjarmasin', 'Batam', 'Bekasi', 'Bogor',
        'Cirebon', 'Denpasar', 'Jakarta', 'Malang', 'Manado', 
        'Medan', 'Palembang', 'Pontianak', 'Semarang', 'Surabaya',
        'Tangerang', 'Depok', 'Makassar', 'Padang', 'Pekanbaru',
        'Samarinda', 'Banjarbaru', 'Jambi', 'Kendari', 'Mataram',
        'Ambon', 'Jayapura', 'Kupang', 'Ternate', 'Bengkulu', 'yogyakarta',
      ];

      // ✅ IMPROVED: Sort cities alphabetically  
      final allCities = {...dbCities, ...extraCities}.toList();
      allCities.sort();

      // ✅ DEBUG: Print untuk verify data separation
      print("🤖 [SMART DROP BOX] DB Cities: $dbCities");
      print("🤖 [SMART DROP BOX] All Cities: ${allCities.length} total");
      print("🤖 [SMART DROP BOX] Drop Boxes: ${dropBoxes.length} drop boxes");

      if (!mounted) return;
      setState(() {
        _cities = allCities;
        _filteredCities = allCities;
        _allDropBoxes = dropBoxes;
        _searchResults = dropBoxes;
        _loading = false;
      });
    } catch (e) {
      print("❌ Error loading Smart Drop Box data: $e");
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
      // ✅ HANYA SMART DROP BOX: Search di tabel smart_drop_box
      final searchResults = await DatabaseHelper.instance.searchSmartDropBox(query);
      final cityResults = await DatabaseHelper.instance.searchSmartDropBoxCities(query);

      // ✅ IMPROVED: Fallback city search if DB search returns empty
      final filteredCities = cityResults.isNotEmpty 
          ? cityResults 
          : _cities.where((city) => city.toLowerCase().contains(query.toLowerCase())).toList();

      print("🤖 [SEARCH] Query: '$query' -> ${searchResults.length} drop boxes, ${filteredCities.length} cities");

      if (!mounted) return;
      setState(() {
        _searchResults = searchResults;
        _filteredCities = filteredCities;
      });
    } catch (e) {
      print("❌ Error searching Smart Drop Box: $e");
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

  // ✅ HANYA SMART DROP BOX: Show Bandung drop boxes
  void _showAllBandungDropBoxes() async {
    try {
      final bandungDropBoxes = await DatabaseHelper.instance.getSmartDropBoxByCity('Bandung');
      
      if (!mounted) return;
      
      if (bandungDropBoxes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Belum ada Smart Drop Box di area ini")),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SmartDropBoxMapScreen(selectedSDB: bandungDropBoxes),
        ),
      );
    } catch (e) {
      print("❌ Error showing Bandung drop boxes: $e");
    }
  }

  void _showSDBList(BuildContext context, String city, List<Map<String, dynamic>> sdbs) {
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (sdbs.isEmpty)
                Column(
                  children: [
                    const Icon(Icons.smart_toy, size: 48, color: Colors.grey),
                    const SizedBox(height: 8),
                    const Text("Belum ada Smart Drop Box untuk kota ini"),
                    const SizedBox(height: 8),
                    // ✅ INFO: Untuk Bandung, berikan context tentang Smart Drop Box real
                    if (city.toLowerCase() == 'bandung')
                      const Text(
                        "💡 Info: Kota Bandung memiliki Smart Drop Box dari program Desa Digital",
                        style: TextStyle(fontSize: 12, color: Colors.orange),
                        textAlign: TextAlign.center,
                      ),
                  ],
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: sdbs.length,
                    itemBuilder: (context, index) {
                      final sdb = sdbs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.smart_toy, color: Colors.orange),
                          title: Text(sdb['nama']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(sdb['lokasi']),
                              Text('Jenis: ${sdb['jenis_sampah']}'),
                              Text('Reward: Rp ${sdb['reward_per_item']}/item'),
                              Text('Jam: ${sdb['jam_operasional']}'),
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SmartDropBoxMapScreen(selectedSDB: sdbs),
                        ),
                      );
                    },
                    child: const Text('Lihat di Peta', style: TextStyle(color: Colors.white)),
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
    // ✅ FIXED: Remove Scaffold, AppBar, BottomNavBar - langsung return content
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              _buildHeader(),
              _buildSearchField(),
              const SizedBox(height: 16),
              _buildLocationButton(),
              const SizedBox(height: 16),
              Expanded(child: _buildSearchResults()), // ✅ CRITICAL: Expanded untuk ListView
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
            'Temukan Smart Drop Box terdekat!',
            style: TextStyle(fontSize: 16, color: Color(0xFF222227)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  _isSearchActive 
                      ? 'Hasil Pencarian "$_searchQuery"' 
                      : 'Semua Lokasi Smart Drop Box',
                  style: const TextStyle(fontSize: 20, color: Color(0xFF222227), fontWeight: FontWeight.w600),
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
          hintText: 'Cari Smart Drop Box atau lokasi...',
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
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF216BC2), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          icon: const Icon(Icons.my_location, color: Colors.white),
          onPressed: _showAllBandungDropBoxes, // ✅ SMART DROP BOX: Show Bandung
          label: const Text(
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
    final hasDropBoxResults = _searchResults.isNotEmpty;

    if (!hasCityResults && !hasDropBoxResults) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.smart_toy, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Tidak ditemukan Smart Drop Box', style: TextStyle(fontSize: 18, color: Colors.grey)),
            Text('Coba kata kunci yang berbeda', style: TextStyle(fontSize: 14, color: Colors.grey)),
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
              itemBuilder: (context, index) => _buildCityTile(_filteredCities[index]),
            ),
            const SizedBox(height: 24),
          ],
          if (hasDropBoxResults) ...[
            _buildSectionHeader('Smart Drop Box (${_searchResults.length})', Icons.smart_toy),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) => _buildDropBoxTile(_searchResults[index]),
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
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF222227))),
      ],
    );
  }

  Widget _buildCityList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemCount: _cities.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) => _buildCityTile(_cities[index]),
      ),
    );
  }

  Widget _buildCityTile(String city) {
    return ListTile(
      leading: const Icon(Icons.smart_toy, color: Color(0xFF3D77BB)), // ✅ SMART DROP BOX ICON
      title: Text(city, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF222227))),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () async {
        final sdbs = await DatabaseHelper.instance.getSmartDropBoxByCity(city);
        if (!context.mounted) return;
        _showSDBList(context, city, sdbs);
      },
    );
  }

  Widget _buildDropBoxTile(Map<String, dynamic> dropBox) {
    return ListTile(
      leading: const Icon(Icons.smart_toy, color: Colors.orange),
      title: Text(dropBox['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dropBox['lokasi']),
          Text('Reward: Rp ${dropBox['reward_per_item']}/item • ${dropBox['status']}',
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(dropBox['city'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF3D77BB))),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: () {
        final city = dropBox['city'] ?? '';
        _showSDBList(context, city, [dropBox]);
      },
    );
  }
}
