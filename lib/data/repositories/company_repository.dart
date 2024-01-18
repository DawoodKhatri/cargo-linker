import 'package:cargo_linker/core/api.dart';

class CompanyRepository {
  final Api _api = Api();

  Future<void> companyEmailVerify(String email) async {
    Map<String, dynamic> body = {"email": email};

    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.post("/company/auth/verification", data: body));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }

  Future<void> companySignup(String email, String password, String otp) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "otp": otp
    };

    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.post("/company/auth/signup", data: body));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }

  Future<void> companyLogin(String email, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    ApiResponse apiResponse = await ApiResponse.handleRequest(
        _api.request.post("/company/auth/login", data: body));

    if (!apiResponse.success) {
      throw apiResponse.message.toString();
    }
  }
}
