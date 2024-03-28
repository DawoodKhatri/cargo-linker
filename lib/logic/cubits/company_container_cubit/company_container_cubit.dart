import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyContainerCubit extends Cubit<CompanyContainerState> {
  CompanyContainerCubit() : super(CompanyContainerInitialState());

  final _containerRepository = ContainerRepository();

  void getListedContainers() async {
    try {
      emit(CompanyContainerLoadingState());
      List<CompanyContainer> containers =
          await _containerRepository.getContainers();
      emit(CompanyContainerListedState(containers: containers));
    } catch (e) {
      emit(CompanyContainerErrorState(e.toString()));
    }
  }

  void submitContainer({
    required String containerId,
    required String type,
    required double size,
    required double dimensionLength,
    required double dimensionWidth,
    required double dimensionHeigth,
    required String price,
    required String pickupAddress,
    required String dropAddress,
    required String due,
  }) async {
    try {
      emit(CompanyContainerLoadingState());
      await _containerRepository.listNewContainers(
        containerId,
        type,
        size,
        dimensionLength,
        dimensionWidth,
        dimensionHeigth,
        price,
        pickupAddress,
        dropAddress,
        due,
      );
      List<CompanyContainer> containers =
          await _containerRepository.getContainers();
      emit(CompanyContainerListedState(containers: containers));
    } catch (e) {
      emit(CompanyContainerErrorState(e.toString()));
    }
  }
}
