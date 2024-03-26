import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderContainerSearchCubit extends Cubit<TraderContainerSearchState> {
  TraderContainerSearchCubit() : super(TraderContainerSearchInitialState());

  final _containerRepository = ContainerRepository();

  void searchPickupLocations(String address) async {
    try {
      emit(TraderContainerSearchLoadingState());

      List<PickupLocation> pickupLocations =
          await _containerRepository.getPickupLocations(address);
      emit(TraderContainerSearchedState(pickupLocations: pickupLocations));
    } catch (e) {
      debugPrint(e.toString());
      emit(TraderContainerSearchErrorState(e.toString()));
    }
  }
}
