import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/logic/cubits/trader_cubit/trader_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderCubit extends Cubit<TraderState> {
  TraderCubit() : super(TraderInitialState());

  final _bookingRepository = BookingRepository();

  void switchToSearch() {
    emit(TraderSearchScreenState());
  }

  void switchToBookings() async {
    try {
      emit(TraderLoadingState());
      List<Booking> bookings = await _bookingRepository.getTraderBookings();
      emit(TraderBookingsScreenState(bookings));
    } catch (e) {
      emit(TraderErrorState(e.toString()));
    }
  }
}
