import 'package:cargo_linker/data/repositories/booking_repository.dart';
import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/logic/cubits/trader_container_booking_cubit/trader_container_booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import "package:flutter/material.dart";

class TraderContainerBookingCubit extends Cubit<TraderContainerBookingState> {
  final Razorpay _razorpay = Razorpay();
  final BookingRepository _bookingRepository = BookingRepository();

  TraderContainerBookingCubit() : super(TraderContainerBookingInitialState()) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void startBooking(CompanyContainer container) {
    try {
      emit(TraderContainerBookingStartedState(container: container));
    } catch (e) {
      emit(TraderContainerBookingErrorState(e.toString()));
    }
  }

  void initiatePayment(String companyName, String containerId) async {
    try {
      emit(TraderContainerBookingPaymentInitiatedState(
          containerId: containerId));

      OrderDetails orderDetails =
          await _bookingRepository.initiatePayment(containerId);

      debugPrint(orderDetails.toString());

      _razorpay.open({
        "key": "rzp_test_aUL5yZsjyEjw8T",
        "amount": orderDetails.amount,
        "name": companyName,
        "description": "Container Id - $containerId",
        "order_id": orderDetails.id,
      });
    } catch (e) {
      emit(TraderContainerBookingErrorState(e.toString()));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    emit(TraderContainerBookingPaymentSuccessState(
        "Container Booked Successfully"));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    emit(TraderContainerBookingErrorState("Payment Failed"));
  }
}
