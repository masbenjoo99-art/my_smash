import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/bank_detail_bottom_sheet.dart';

class BankMapScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedBanks;

  const BankMapScreen({super.key, required this.selectedBanks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peta Bank Sampah"),
        backgroundColor: Colors.green,
      ),
      body: selectedBanks.isEmpty
          ? const Center(child: Text("Belum ada bank sampah untuk lokasi ini"))
          : FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                  (selectedBanks[0]['latitude'] as num?)?.toDouble() ?? -7.7972,
                  (selectedBanks[0]['longitude'] as num?)?.toDouble() ??
                      110.3688,
                ),
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.recycleapp',
                ),
                MarkerLayer(
                  markers: selectedBanks.map((bank) {
                    final double lat =
                        (bank['latitude'] as num?)?.toDouble() ?? 0.0;
                    final double lng =
                        (bank['longitude'] as num?)?.toDouble() ?? 0.0;

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
                                BankDetailBottomSheet(bank: bank),
                          );
                        },
                        child: const Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.red,
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
