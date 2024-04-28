import 'package:cargo_linker/core/ui.dart';
import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContainerCard extends StatelessWidget {
  final CompanyContainer container;
  const ContainerCard({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    DateTime dueDate = DateTime.parse(container.due).toLocal();

    // List<PointLatLng> polylinePoints =
    //     PolylinePoints().decodePolyline(container.encodedPolylinePoints);

    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            container.companyName != null
                ? Text(container.companyName ?? "")
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Id: ${container.containerId}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppThemes.light.primaryColor),
                      child: Text(
                        container.type,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const Spacing(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppThemes.light.primaryColor),
                      child: Text(
                        "₹${container.price}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "Dimension: ${container.dimension["length"]} x ${container.dimension["width"]} x ${container.dimension["height"]} Feet",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            // Text("Pickup Location: $pickup"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ToggleButtons(
                  constraints:
                      const BoxConstraints(minWidth: 48, minHeight: 28),
                  textStyle: const TextStyle(fontSize: 14),
                  onPressed: (value) {},
                  isSelected: [
                    container.size == "20",
                    container.size == "30",
                    container.size == "40"
                  ],
                  children: const [
                    Text("20 Ft"),
                    Text("30 Ft"),
                    Text("40 Ft"),
                  ],
                ),
                Text(
                  "${dueDate.day}/${dueDate.month}/${dueDate.year}",
                  style: TextStyle(
                      color: AppThemes.light.primaryColor, fontSize: 16),
                )
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              height: 175,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(container.pickup.lat, container.pickup.long),
                  // target: LatLng(
                  //     (container.pickup.lat + container.drop.lat + 0.012) / 2,
                  //     (container.pickup.long + container.drop.long + 0.012) /
                  //         2),
                  zoom: 12,
                ),
                markers: {
                  Marker(
                    icon: BitmapDescriptor.defaultMarkerWithHue(120),
                    markerId: const MarkerId("pickupMarker"),
                    position:
                        LatLng(container.pickup.lat, container.pickup.long),
                    infoWindow: InfoWindow(
                        title: container.pickup.address,
                        snippet: "Pickup Location"),
                  ),
                  Marker(
                    markerId: const MarkerId("dropMarker"),
                    position: LatLng(container.drop.lat, container.drop.long),
                    infoWindow: InfoWindow(
                        title: container.drop.address,
                        snippet: "Drop Location"),
                  ),
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("polyline"),
                    color: AppThemes.light.primaryColor,
                    width: 3,
                    points: 
                    // polylinePoints.isNotEmpty
                    //     ? polylinePoints
                    //         .map((point) =>
                    //             LatLng(point.latitude, point.longitude))
                    //         .toList()
                    //     : 
                        [
                            LatLng(container.pickup.lat, container.pickup.long),
                            LatLng(container.drop.lat, container.drop.long),
                          ],
                  )
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
