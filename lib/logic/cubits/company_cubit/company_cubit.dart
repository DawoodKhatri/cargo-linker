import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/logic/cubits/company_cubit/company_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitialState());

  final _containerRepository = ContainerRepository();
  final _bookingRepository = BookingRepository();

  void switchToDetails() {
    emit(CompanyDetailsScreenState());
  }

  void switchToContainers() async {
    try {
      emit(CompanyContainersScreenState(containers: [], isLoading: true));
      List<CompanyContainer> containers =
          await _containerRepository.getContainers();
      emit(CompanyContainersScreenState(containers: containers));
    } catch (e) {
      emit(CompanyErrorState(e.toString()));
    }
  }

  void switchToBookings() async {
    try {
      emit(CompanyBookingsScreenState(bookings: [], isLoading: true));
      List<Booking> bookings = await _bookingRepository.getCompanyBookings();
      emit(CompanyBookingsScreenState(bookings: bookings));
    } catch (e) {
      emit(CompanyErrorState(e.toString()));
    }
  }
}
