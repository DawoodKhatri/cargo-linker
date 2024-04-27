import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/data/repositories/container_repository.dart';

abstract class CompanyState {}

class CompanyInitialState extends CompanyState {}

class CompanyErrorState extends CompanyState {
  final String message;
  CompanyErrorState(this.message);
}

class CompanyDetailsScreenState extends CompanyState {}

class CompanyContainersScreenState extends CompanyState {
  final List<CompanyContainer> containers;
  final bool isLoading;
  CompanyContainersScreenState(
      {required this.containers, this.isLoading = false});
}

class CompanyBookingsScreenState extends CompanyState {
  final List<Booking> bookings;
  final bool isLoading;
  CompanyBookingsScreenState({required this.bookings, this.isLoading = false});
}
