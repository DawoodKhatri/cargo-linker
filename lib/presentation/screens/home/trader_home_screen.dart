import 'dart:async';

import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TraderHomeScreen extends StatefulWidget {
  const TraderHomeScreen({super.key});

  static const String routeName = "traderHome";

  @override
  State<TraderHomeScreen> createState() => _TraderHomeScreenState();
}

class _TraderHomeScreenState extends State<TraderHomeScreen> {
  final Completer<GoogleMapController> _map_controller =
      Completer<GoogleMapController>();

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
          body: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(18.9681556, 72.8313206),
                zoom: 13,
              ),
              markers: {
                const Marker(
                  markerId: MarkerId("saboosiddik"),
                  position: LatLng(18.9681556, 72.8313206),
                )
              })),
    );
  }
}
