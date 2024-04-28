import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/presentation/screens/booking/container_details.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.booking});
  final Booking booking;

  static const String routeName = "bookingDetails";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOOKING DETAILS"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      booking.companyName ?? booking.traderName ?? "",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      booking.companyEmail ?? booking.traderEmail ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacing(
                multiply: 3,
              ),
              ContainerDetails(container: booking.container),
              const Spacing(
                multiply: 3,
              ),
              Text(
                "Order id: ${booking.orderId}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacing(),
              ...[
                booking.companyId == null
                    ? Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: booking.paymentDisbursed
                                  ? Colors.green.shade600
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              booking.paymentDisbursed
                                  ? Icons.check
                                  : Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          const Spacing(),
                          Text(
                            booking.paymentDisbursed
                                ? "Payment Transferred"
                                : "Payment transfer pending",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                    : Text(
                        "Note: Your package should be arrived at the pickup location before the dispatch date. If not, the booking will be cancelled.",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
