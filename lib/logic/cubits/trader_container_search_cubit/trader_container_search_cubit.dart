import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderContainerSearchCubit extends Cubit<TraderContainerSearchState> {
  TraderContainerSearchCubit() : super(TraderContainerSearchInitialState());

  final _containerRepository = ContainerRepository();

  void searchPickupLocations(String pickupAddress, String dropAddress) async {
    try {
      emit(TraderContainerSearchLoadingState());

      List<CompanyContainer> containers = await _containerRepository
          .getPickupLocations(pickupAddress, dropAddress);
      emit(TraderContainerSearchedState(containers: containers));
    } catch (e) {
      debugPrint(e.toString());
      emit(TraderContainerSearchErrorState(e.toString()));
    }
  }
}
