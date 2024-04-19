import 'package:cargo_linker/data/repositories/container_repository.dart';

abstract class TraderContainerBookingState {}

class TraderContainerBookingInitialState extends TraderContainerBookingState {}

class TraderContainerBookingLoadingState extends TraderContainerBookingState {}

class TraderContainerBookingErrorState extends TraderContainerBookingState {
  final String message;
  TraderContainerBookingErrorState(this.message);
}

class TraderContainerBookingSearchedState extends TraderContainerBookingState {
  final List<CompanyContainer> containers;
  TraderContainerBookingSearchedState({required this.containers});
}

class TraderContainerBookingStartedState extends TraderContainerBookingState {
  final CompanyContainer container;
  TraderContainerBookingStartedState({required this.container});
}
