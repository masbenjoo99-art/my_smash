import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SmartDropBoxDetailScreen extends StatelessWidget {
  final Map<String, dynamic> sdb;

  const SmartDropBoxDetailScreen({super.key, required this.sdb});

  @override
  Widget build(BuildContext context) {
    final double lat = (sdb['latitude'] as num?)?.toDouble() ?? 0.0;
    final double lng = (sdb['longitude'] as num?)?.toDouble() ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(sdb['nama'] ?? "Detail Smart Drop Box"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // 🔹 Informasi umum
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sdb['nama'] ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.red),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        sdb['lokasi'] ?? '',
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Jenis Sampah: ${sdb['jenis_sampah'] ?? '-'}"),
                Text("Status: ${sdb['status'] ?? 'Tidak diketahui'}"),
                Text("Reward/item: ${sdb['reward_per_item'] ?? 0} poin"),
                Text("Jam Operasional: ${sdb['jam_operasional'] ?? '-'}"),
              ],
            ),
          ),

          // 🔹 Peta
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
                        color: Colors.blue,
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
