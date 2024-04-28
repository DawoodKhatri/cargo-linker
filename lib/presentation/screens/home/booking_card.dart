import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/presentation/screens/booking/booking_details.dart';
import 'package:cargo_linker/presentation/screens/home/container_card.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      BookingDetailsScreen.routeName,
                      arguments: booking,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        booking.companyName ?? booking.traderName ?? "",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 32,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  )),
              Text(
                booking.orderId,
                style: const TextStyle(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
              const Spacing(),
              const Text(
                "Container Details",
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
        ContainerCard(container: booking.container),
      ],
    );
  }
}
