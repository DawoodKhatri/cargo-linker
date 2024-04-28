import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/trader_container_booking_cubit/trader_container_booking_cubit.dart';
import 'package:cargo_linker/logic/cubits/trader_container_booking_cubit/trader_container_booking_state.dart';
import 'package:cargo_linker/presentation/screens/booking/container_details.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderBookingScreen extends StatelessWidget {
  const TraderBookingScreen({super.key});

  static const String routeName = "traderBooking";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return Column(
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
                            SERVICE_TYPES_ICON[state.container.serviceType],
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const Spacing(
                          multiply: 1,
                        ),
                        Text(
                          state.container.companyName ?? "",
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2),
                        ),
                      ],
                    ),
                    const Spacing(
                      multiply: 3,
                    ),
                    ContainerDetails(container: state.container),
                    const Spacing(
                      multiply: 3,
                    ),
                    PrimaryButton(
                        onPressed: () {
                          BlocProvider.of<TraderContainerBookingCubit>(context)
                              .initiatePayment(
                                  state.container.companyName ?? "",
                                  state.container.id);
                        },
                        child: const Text("Make Payment & Book"))
                  ],
                );
              }

              if (state is TraderContainerBookingPaymentInitiatedState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Spacing(
                        multiply: 2,
                      ),
                      Text("Initiating Payment..."),
                      Spacing(
                        multiply: 15,
                      )
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
