import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderContainerBookingCubit extends Cubit<TraderContainerBookingState> {
  TraderContainerBookingCubit() : super(TraderContainerBookingInitialState());

  final _containerRepository = ContainerRepository();

  void searchContainers(String pickupAddress, String dropAddress) async {
    try {
      emit(TraderContainerBookingLoadingState());

      List<CompanyContainer> containers = await _containerRepository
          .searchContainers(pickupAddress, dropAddress);
      emit(TraderContainerBookingSearchedState(containers: containers));
    } catch (e) {
      emit(TraderContainerBookingErrorState(e.toString()));
    }
  }

  void startBooking(CompanyContainer container) {
    try {
      emit(TraderContainerBookingStartedState(container: container));
    } catch (e) {
      emit(TraderContainerBookingErrorState(e.toString()));
    }
  }
}
