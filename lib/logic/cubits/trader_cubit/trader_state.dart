import 'package:cargo_linker/data/repositories/booking_repository.dart';

abstract class TraderState {
  final List<Booking> bookings = [];
}

class TraderInitialState extends TraderState {}

class TraderLoadingState extends TraderState {}

class TraderErrorState extends TraderState {
  final String message;
  TraderErrorState(this.message);
}

class TraderBookingsScreenState extends TraderState {
  final List<Booking> bookings;
  TraderBookingsScreenState(this.bookings);
}

class TraderSearchScreenState extends TraderState {}
