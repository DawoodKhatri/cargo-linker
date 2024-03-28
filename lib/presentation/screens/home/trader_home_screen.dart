import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_cubit.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_state.dart';
import 'package:cargo_linker/presentation/screens/home/container_card.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_text_field.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderHomeScreen extends StatefulWidget {
  const TraderHomeScreen({super.key});

  static const String routeName = "traderHome";

  @override
  State<TraderHomeScreen> createState() => _TraderHomeScreenState();
}

class _TraderHomeScreenState extends State<TraderHomeScreen> {
  final pickupLocationController = TextEditingController();
  final dropLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("HOME"),
            centerTitle: false,
            actions: [
              IconButton(onPressed: () {
                BlocProvider.of<AuthCubit>(context).logout();
              }, icon: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return const Icon(Icons.logout);
                },
              )),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PrimaryTextField(
                    controller: pickupLocationController,
                    labelText: 'Pickup Location',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter the drop location';
                      }
                      return null;
                    },
                  ),
                  const Spacing(
                    multiply: 2,
                  ),
                  PrimaryTextField(
                    controller: dropLocationController,
                    labelText: 'Drop Location',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter the drop location';
                      }
                      return null;
                    },
                  ),
                  const Spacing(
                    multiply: 2,
                  ),
                  PrimaryButton(
                    child: const Text("Search"),
                    onPressed: () {
                      BlocProvider.of<TraderContainerSearchCubit>(context)
                          .searchPickupLocations(pickupLocationController.text,
                              dropLocationController.text);
                    },
                  ),
                  const Spacing(
                    multiply: 2,
                  ),
                  BlocBuilder<TraderContainerSearchCubit,
                      TraderContainerSearchState>(
                    builder: (context, state) {
                      if (state is TraderContainerSearchLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is TraderContainerSearchedState) {
                        return Column(
                          children: state.containers.reversed
                              .map((container) => Column(
                                    children: [
                                      ContainerCard(
                                        container: container,
                                      ),
                                      const Spacing(
                                        multiply: 2,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        );

                        // return GoogleMap(
                        //     mapType: MapType.normal,
                        //     initialCameraPosition: CameraPosition(
                        //       target: LatLng(state.pickupLocations[0].lat,
                        //           state.pickupLocations[0].long),
                        //       zoom: 13,
                        //     ),
                        //     markers: state.pickupLocations
                        //         .map((location) => Marker(
                        //               markerId: MarkerId(location.containerId),
                        //               position:
                        //                   LatLng(location.lat, location.long),
                        //             ))
                        //         .toSet());
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
