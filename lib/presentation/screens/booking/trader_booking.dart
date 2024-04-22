import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_cubit.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_state.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TraderBookingScreen extends StatelessWidget {
  const TraderBookingScreen({super.key});

  static const String routeName = "traderBooking";

  @override
  Widget build(BuildContext context) {
    return BlocListener<TraderContainerBookingCubit,
        TraderContainerBookingState>(
      listener: (context, state) {
        if (state is TraderContainerBookingStartedState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BOOKING"),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<TraderContainerBookingCubit,
                TraderContainerBookingState>(
              builder: (context, state) {
                if (state is TraderContainerBookingStartedState) {
                  DateTime dueDate =
                      DateTime.parse(state.container.due).toLocal();
                  List<PointLatLng> polylinePoints = PolylinePoints()
                      .decodePolyline(state.container.encodedPolylinePoints);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(360),
                            ),
                            child: Icon(
                              SERVICE_TYPES_ICON[state.container.serviceType],
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          Spacing(
                            multiply: 1,
                          ),
                          Text(
                            state.container.companyName ?? "",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2),
                          ),
                        ],
                      ),
                      Spacing(
                        multiply: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Id: ${state.container.containerId}",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              Spacing(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context).primaryColor),
                                child: Text(
                                  state.container.type,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹${state.container.price}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacing(
                        multiply: 3,
                      ),
                      Text(
                        "Container Size: ${state.container.size} Feet",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Spacing(),
                      Text(
                        "Available Space: ${state.container.dimension["length"]} x ${state.container.dimension["width"]} x ${state.container.dimension["height"]} Feet",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Spacing(),
                      Text(
                        "Dispatch on: ${dueDate.day}/${dueDate.month}/${dueDate.year}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacing(
                        multiply: 3,
                      ),
                      Text(
                        "Location",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      Spacing(
                        multiply: 1,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 275,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(state.container.pickup.lat,
                                state.container.pickup.long),
                            // target: LatLng(
                            //     (state.container.pickup.lat +
                            //             state.container.drop.lat +
                            //             0.008) /
                            //         2,
                            //     (state.container.pickup.long +
                            //             state.container.drop.long +
                            //             0.012) /
                            //         2),
                            zoom: 13,
                          ),
                          markers: {
                            Marker(
                              icon: BitmapDescriptor.defaultMarkerWithHue(120),
                              markerId: const MarkerId("pickupMarker"),
                              position: LatLng(state.container.pickup.lat,
                                  state.container.pickup.long),
                              infoWindow: InfoWindow(
                                  title: state.container.pickup.address,
                                  snippet: "Pickup Location"),
                            ),
                            Marker(
                              markerId: const MarkerId("dropMarker"),
                              position: LatLng(state.container.drop.lat,
                                  state.container.drop.long),
                              infoWindow: InfoWindow(
                                  title: state.container.drop.address,
                                  snippet: "Drop Location"),
                            ),
                          },
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("polyline"),
                              color: Theme.of(context).primaryColor,
                              width: 3,
                              points: polylinePoints
                                  .map((point) =>
                                      LatLng(point.latitude, point.longitude))
                                  .toList(),
                            )
                          },
                        ),
                      ),
                      Spacing(
                        multiply: 2,
                      ),
                      PrimaryButton(onPressed: () {}, child: Text("Book Now"))
                    ],
                  );
                }

                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
