import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/logic/cubits/company_cubit/company_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_cubit/company_state.dart';
import 'package:cargo_linker/presentation/screens/home/booking_card.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyBookingsTab extends StatelessWidget {
  const CompanyBookingsTab({super.key, required this.bookings});

  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        if (state is CompanyBookingsScreenState && state.isLoading) {
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
              "Bookings",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
              ),
            ),
          const  Spacing(
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
                .toList(),
          ],
        );
      },
    );
  }
}
