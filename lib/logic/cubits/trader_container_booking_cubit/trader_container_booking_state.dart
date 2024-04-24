import 'package:cargo_linker/data/repositories/container_repository.dart';

abstract class TraderContainerBookingState {}

class TraderContainerBookingInitialState extends TraderContainerBookingState {}

class TraderContainerBookingLoadingState extends TraderContainerBookingState {}

class TraderContainerBookingErrorState extends TraderContainerBookingState {
  final String message;
  TraderContainerBookingErrorState(this.message);
}

class TraderContainerBookingStartedState extends TraderContainerBookingState {
  final CompanyContainer container;
  TraderContainerBookingStartedState({required this.container});
}

class TraderContainerBookingPaymentInitiatedState
    extends TraderContainerBookingState {
  final String containerId;
  TraderContainerBookingPaymentInitiatedState({required this.containerId});
}

class TraderContainerBookingPaymentSuccessState
    extends TraderContainerBookingState {
  final String message;
  TraderContainerBookingPaymentSuccessState(this.message);
}
