import 'package:cargo_linker/data/repositories/container_repository.dart';

abstract class TraderContainerSearchState {}

class TraderContainerSearchInitialState extends TraderContainerSearchState {}

class TraderContainerSearchLoadingState extends TraderContainerSearchState {}

class TraderContainerSearchErrorState extends TraderContainerSearchState {
  final String message;
  TraderContainerSearchErrorState(this.message);
}

class TraderContainerSearchedState extends TraderContainerSearchState {
  final List<PickupLocation> pickupLocations;
  TraderContainerSearchedState({required this.pickupLocations});
}
