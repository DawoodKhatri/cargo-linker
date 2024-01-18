import 'package:cargo_linker/core/api.dart';

class AuthRepository {
  final Api _api = Api();

  Future<void> getUser() async {
    ApiResponse apiResponse =
        await ApiResponse.handleRequest(_api.request.get("/auth/details"));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }

  Future<void> logoutUser() async {
    ApiResponse apiResponse =
        await ApiResponse.handleRequest(_api.request.post("/auth/logout"));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }
}
