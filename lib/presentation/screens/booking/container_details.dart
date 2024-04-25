import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContainerDetails extends StatelessWidget {
  final CompanyContainer container;
  const ContainerDetails({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    DateTime dueDate = DateTime.parse(container.due).toLocal();
    List<PointLatLng> polylinePoints =
        PolylinePoints().decodePolyline(container.encodedPolylinePoints);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(360),
              ),
              child: Icon(
                SERVICE_TYPES_ICON[container.serviceType],
                size: 22,
                color: Colors.white,
              ),
            ),
            const Spacing(
              multiply: 1,
            ),
            Text(
              container.companyName ?? "",
              style: const TextStyle(
                  fontSize: 32, fontWeight: FontWeight.w600, letterSpacing: 2),
            ),
          ],
        ),
        const Spacing(
          multiply: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Id: ${container.containerId}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const Spacing(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).primaryColor),
                  child: Text(
                    container.type,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Text(
              "₹${container.price}",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacing(
          multiply: 3,
        ),
        Text(
          "Container Size: ${container.size} Feet",
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const Spacing(),
        Text(
          "Available Space: ${container.dimension["length"]} x ${container.dimension["width"]} x ${container.dimension["height"]} Feet",
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const Spacing(),
        Text(
          "Dispatch on: ${dueDate.day}/${dueDate.month}/${dueDate.year}",
          style: const TextStyle(fontSize: 18),
        ),
        const Spacing(
          multiply: 3,
        ),
        const Text(
          "Location",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const Spacing(
          multiply: 1,
        ),
        SizedBox(
          width: double.maxFinite,
          height: 250,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(container.pickup.lat, container.pickup.long),
              // target: LatLng(
              //     (container.pickup.lat +
              //             container.drop.lat +
              //             0.008) /
              //         2,
              //     (container.pickup.long +
              //             container.drop.long +
              //             0.012) /
              //         2),
              zoom: 13,
            ),
            markers: {
              Marker(
                icon: BitmapDescriptor.defaultMarkerWithHue(120),
                markerId: const MarkerId("pickupMarker"),
                position: LatLng(container.pickup.lat, container.pickup.long),
                infoWindow: InfoWindow(
                    title: container.pickup.address,
                    snippet: "Pickup Location"),
              ),
              Marker(
                markerId: const MarkerId("dropMarker"),
                position: LatLng(container.drop.lat, container.drop.long),
                infoWindow: InfoWindow(
                    title: container.drop.address, snippet: "Drop Location"),
              ),
            },
            polylines: {
              Polyline(
                polylineId: const PolylineId("polyline"),
                color: Theme.of(context).primaryColor,
                width: 3,
                points: polylinePoints.isNotEmpty
                    ? polylinePoints
                        .map((point) => LatLng(point.latitude, point.longitude))
                        .toList()
                    : [
                        LatLng(container.pickup.lat, container.pickup.long),
                        LatLng(container.drop.lat, container.drop.long),
                      ],
              )
            },
          ),
        ),
      ],
    );
  }
}
