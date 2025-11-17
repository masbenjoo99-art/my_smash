import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BankDetailScreen extends StatelessWidget {
  final Map<String, dynamic> bank;

  const BankDetailScreen({super.key, required this.bank});

  @override
  Widget build(BuildContext context) {
    // ✅ Pastikan latitude/longitude dikonversi ke double
    final double lat = (bank['latitude'] as num?)?.toDouble() ?? 0.0;
    final double lng = (bank['longitude'] as num?)?.toDouble() ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(bank['nama'] ?? "Detail Bank Sampah"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Informasi nama + alamat
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bank['nama'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(bank['alamat'] ?? ''),
              ],
            ),
          ),

          // Peta OpenStreetMap
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(lat, lng),
                initialZoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.recycleapp',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(lat, lng),
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
