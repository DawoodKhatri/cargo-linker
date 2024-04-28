import 'package:cargo_linker/data/repositories/booking_repository.dart';

abstract class TraderState {}

class TraderInitialState extends TraderState {}

class TraderErrorState extends TraderState {
  final String message;
  TraderErrorState(this.message);
}

class TraderBookingsScreenState extends TraderState {
  final List<Booking> bookings;
  final bool isLoading;
  TraderBookingsScreenState({required this.bookings, this.isLoading = false});
}

class TraderSearchScreenState extends TraderState {}
