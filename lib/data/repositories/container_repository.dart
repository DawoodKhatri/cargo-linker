import 'package:cargo_linker/core/api.dart';

class CompanyContainer {
  final String containerId;
  final String type;
  final String size;
  final Map<String, dynamic> pickup;
  final Map<String, dynamic> drop;
  final String due;
  final Map<String, dynamic> dimension;
  final String price;

  CompanyContainer({
    required this.containerId,
    required this.type,
    required this.size,
    required this.pickup,
    required this.drop,
    required this.due,
    required this.dimension,
    required this.price,
  });

  factory CompanyContainer.fromJson(Map<String, dynamic> json) {
    return CompanyContainer(
      containerId: json["containerId"],
      type: json["type"],
      size: json["size"].toString(),
      pickup: {
        "lat": json["pickup"]["lat"].toString(),
        "long": json["pickup"]["long"].toString(),
      },
      drop: {
        "lat": json["pickup"]["lat"].toString(),
        "long": json["pickup"]["long"].toString(),
      },
      due: json["due"],
      dimension: {
        "length": json["dimension"]["length"].toString(),
        "width": json["dimension"]["width"].toString(),
        "height": json["dimension"]["height"].toString(),
      },
      price: json["price"].toString(),
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
    double pickupLat,
    double pickupLong,
    double dropLat,
    double dropLong,
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
      "pickup": {
        "lat": pickupLat,
        "long": pickupLong,
      },
      "drop": {
        "lat": dropLat,
        "long": dropLong,
      }
    };
    ApiResponse apiResponse = await ApiResponse.handleRequest(_api.request.post(
      "/company/containers",
      data: body,
    ));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }

  Future<List<PickupLocation>> getPickupLocations(String address) async {
    ApiResponse apiResponse = await ApiResponse.handleRequest(_api.request.get(
      "/trader/getPickupLocations?address=$address",
    ));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }

    List<PickupLocation> pickupLocations =
        (apiResponse.data["pickupLocations"] as List)
            .map((location) => PickupLocation.fromJson(location))
            .toList();

    return pickupLocations;
  }
}
