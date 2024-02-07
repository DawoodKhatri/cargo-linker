import 'package:cargo_linker/core/api.dart';

class TraderRepository {
  final Api _api = Api();

  Future<void> emailVerify(String email) async {
    Map<String, dynamic> body = {"email": email};

    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.post("/trader/auth/verification", data: body));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }

  Future<void> signup(String email, String password, String otp) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "otp": otp
    };

    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.post("/trader/auth/signup", data: body));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }

  Future<void> login(String email, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.post("/trader/auth/login", data: body));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }
}
