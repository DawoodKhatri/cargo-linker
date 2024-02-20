import 'package:cargo_linker/data/repositories/container_repository.dart';

abstract class CompanyContainerState {}

class CompanyContainerInitialState extends CompanyContainerState {}

class CompanyContainerLoadingState extends CompanyContainerState {}

class CompanyContainerErrorState extends CompanyContainerState {
  final String message;
  CompanyContainerErrorState(this.message);
}

class CompanyContainerListedState extends CompanyContainerState {
  final List<CompanyContainer> containers;
  CompanyContainerListedState({required this.containers});
}
