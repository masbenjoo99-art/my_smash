import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/smart_drop_box_detail_bottom_sheet.dart';

class SmartDropBoxMapScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedSDB;

  const SmartDropBoxMapScreen({super.key, required this.selectedSDB});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 32,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
        backgroundColor: const Color(0xFF216BC2),
      ),
      body: selectedSDB.isEmpty
          ? const Center(child: Text("Belum ada Smart Drop Box untuk lokasi ini"))
          : FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                  (selectedSDB[0]['latitude'] as num?)?.toDouble() ?? -6.9175,
                  (selectedSDB[0]['longitude'] as num?)?.toDouble() ?? 107.6191,
                ),
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.recycleapp',
                ),
                MarkerLayer(
                  markers: selectedSDB.map((sdb) {
                    final double lat =
                        (sdb['latitude'] as num?)?.toDouble() ?? 0.0;
                    final double lng =
                        (sdb['longitude'] as num?)?.toDouble() ?? 0.0;

                    return Marker(
                      point: LatLng(lat, lng),
                      width: 80,
                      height: 80,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                SmartDropBoxDetailBottomSheet(sdb: sdb),
                          );
                        },
                        child: const Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
