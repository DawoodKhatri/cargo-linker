import 'package:cargo_linker/core/api.dart';

class Location {
  final String address;
  final double lat;
  final double long;

  Location({required this.address, required this.lat, required this.long});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        address: json["address"],
        lat: json["lat"] + 0.0,
        long: json["long"] + 0.0);
  }
}

class CompanyContainer {
  final String containerId;
  final String type;
  final String size;
  final Location pickup;
  final Location drop;
  final String encodedPolylinePoints;
  final String due;
  final Map<String, dynamic> dimension;
  final String price;
  final String companyName;
  final String serviceType;

  CompanyContainer({
    required this.containerId,
    required this.type,
    required this.size,
    required this.pickup,
    required this.drop,
    required this.encodedPolylinePoints,
    required this.due,
    required this.dimension,
    required this.price,
    required this.companyName,
    required this.serviceType,
  });

  factory CompanyContainer.fromJson(Map<String, dynamic> json) {
    return CompanyContainer(
      containerId: json["containerId"],
      type: json["type"],
      size: json["size"].toString(),
      pickup: Location.fromJson(json["pickup"]),
      drop: Location.fromJson(json["drop"]),
      encodedPolylinePoints: json["encodedPolylinePoints"]??"",
      due: json["due"],
      dimension: {
        "length": json["dimension"]["length"].toString(),
        "width": json["dimension"]["width"].toString(),
        "height": json["dimension"]["height"].toString(),
      },
      price: json["price"].toString(),
      companyName: json["companyName"],
      serviceType: json["serviceType"],
    );
  }
}

class PickupLocation {
  final double lat;
  final double long;
  final String containerId;

  PickupLocation(
      {required this.lat, required this.long, required this.containerId});

  factory PickupLocation.fromJson(Map<String, dynamic> json) {
    return PickupLocation(
      lat: json["pickup"]["lat"] + 0.0,
      long: json["pickup"]["long"] + 0.0,
      containerId: json["_id"],
    );
  }
}

class ContainerRepository {
  final Api _api = Api();

  Future<List<CompanyContainer>> getContainers() async {
    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.get("/company/containers"));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }

    List<CompanyContainer> containers = (apiResponse.data["containers"] as List)
        .map((container) => CompanyContainer.fromJson(container))
        .toList();

    return containers;
  }

  Future<void> listNewContainers(
    String containerId,
    String type,
    double size,
    double dimensionLength,
    double dimensionWidth,
    double dimensionHeigth,
    String price,
    String pickupAddress,
    String dropAddress,
    String due,
  ) async {
    Map<String, dynamic> body = {
      "containerId": containerId,
      "type": type,
      "size": size,
      "due": due,
      "dimension": {
        "length": dimensionLength,
        "width": dimensionWidth,
        "height": dimensionHeigth,
      },
      "price": price,
      "pickupAddress": pickupAddress,
      "dropAddress": dropAddress
    };
    ApiResponse apiResponse = await ApiResponse.handleRequest(_api.request.post(
      "/company/containers",
      data: body,
    ));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }

  Future<List<CompanyContainer>> searchContainers(
      String pickupAddress, String dropAddress) async {
    ApiResponse apiResponse = await ApiResponse.handleRequest(_api.request.get(
      "/trader/searchContainers?pickupAddress=$pickupAddress&dropAddress=$dropAddress",
    ));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }

    List<CompanyContainer> containers = (apiResponse.data["containers"] as List)
        .map((container) => CompanyContainer.fromJson(container))
        .toList();

    return containers;
  }
}
