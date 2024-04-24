import 'package:cargo_linker/core/api.dart';

class OrderDetails {
  final String id;
  final int amount;

  OrderDetails({required this.id, required this.amount});

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(id: json["id"], amount: json["amount"]);
  }
}

class BookingRepository {
  final Api _api = Api();

  Future<OrderDetails> initiatePayment(String containerId) async {
    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.post("/trader/container/$containerId/startBooking"));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
    return OrderDetails.fromJson(apiResponse.data["order"]);
  }
}
