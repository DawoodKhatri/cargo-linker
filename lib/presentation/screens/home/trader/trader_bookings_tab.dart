import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/logic/cubits/trader_cubit/trader_cubit.dart';
import 'package:cargo_linker/logic/cubits/trader_cubit/trader_state.dart';
import 'package:cargo_linker/presentation/screens/home/booking_card.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderBookingsTab extends StatelessWidget {
  const TraderBookingsTab({super.key, required this.bookings});
  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TraderCubit, TraderState>(builder: (context, state) {
      if (state is TraderBookingsScreenState && state.isLoading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Bookings",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacing(
            multiply: 3,
          ),
          ...bookings
              .map(
                (booking) => Column(
                  children: [
                    BookingCard(
                      booking: booking,
                    ),
                    const Spacing(
                      multiply: 3,
                    )
                  ],
                ),
              )
              .toList()
        ],
      );
    });
  }
}
