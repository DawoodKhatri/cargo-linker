import 'package:cargo_linker/core/api.dart';
import 'package:cargo_linker/data/repositories/container_repository.dart';

class OrderDetails {
  final String id;
  final int amount;

  OrderDetails({required this.id, required this.amount});

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(id: json["id"], amount: json["amount"]);
  }
}

class Booking {
  final String id;
  final CompanyContainer container;
  final String? companyId;
  final String? companyName;
  final String? companyServiceType;
  final String? traderId;
  final String? traderName;
  final String orderId;
  final double amount;
  final bool paymentDisbursed;

  Booking({
    required this.id,
    required this.container,
    this.companyId,
    this.companyName,
    this.companyServiceType,
    this.traderId,
    this.traderName,
    required this.orderId,
    required this.amount,
    required this.paymentDisbursed,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json["_id"],
      container: CompanyContainer.fromJson(json["container"]),
      companyId: json["company"]?["_id"],
      companyName: json["company"]?["name"],
      companyServiceType: json["company"]?["serviceType"],
      traderId: json["trader"]?["_id"],
      traderName: json["trader"]?["name"],
      orderId: json["orderId"],
      amount: double.parse(json["amount"].toString()),
      paymentDisbursed: json["paymentDisbursed"] ?? false,
    );
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

  Future<List<Booking>> getTraderBookings() async {
    ApiResponse apiResponse =
        await ApiResponse.handleRequest(_api.request.get("/trader/bookings"));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }

    List<Booking> bookings = (apiResponse.data["bookings"] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
    return bookings;
  }

  Future<List<Booking>> getCompanyBookings() async {
    ApiResponse apiResponse =
        await ApiResponse.handleRequest(_api.request.get("/company/bookings"));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }

    List<Booking> bookings = (apiResponse.data["bookings"] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
    return bookings;
  }
}
