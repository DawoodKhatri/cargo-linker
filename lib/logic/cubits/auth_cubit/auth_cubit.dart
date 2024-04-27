import 'package:cargo_linker/data/constants/user_roles.dart';
import 'package:cargo_linker/data/repositories/auth_repository.dart';
import 'package:cargo_linker/data/repositories/company_repository.dart';
import 'package:cargo_linker/data/repositories/trader_repository.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final _authRepository = AuthRepository();
  final _companyRepository = CompanyRepository();
  final _traderRepository = TraderRepository();

  String _type = USER_ROLES.company;
  late String? _name;
  late String _email;
  late String _password;

  String get type => _type;
  String? get name => _name;
  String get email => _email;
  String get password => _password;

  void authCheck() async {
    try {
      emit(AuthLoadingState());
      _type = await _authRepository.getUser();
      emit(AuthLoggedInState());
    } catch (ex) {
      emit(AuthErrorState(ex.toString()));
    }
  }

  void switchType(type) {
    _type = type;
    emit(AuthLoggedOutState());
  }

  void emailVerify(String? name, String email, String password) async {
    try {
      _name = name;
      _email = email;
      _password = password;
      emit(AuthLoadingState());
      if (type == USER_ROLES.company) {
        await _companyRepository.companyEmailVerify(email);
      } else {
        await _traderRepository.emailVerify(email);
      }
      emit(AuthOTPVerificationState());
    } catch (ex) {
      emit(AuthErrorState(ex.toString()));
    }
  }

  void resendEmailVerification() async {
    try {
      emit(AuthLoadingState());
      if (type == USER_ROLES.company) {
        await _companyRepository.companyEmailVerify(_email);
      } else {
        await _traderRepository.emailVerify(_email);
      }
      emit(AuthOTPVerificationState(isResend: true));
    } catch (ex) {
      emit(AuthErrorState(ex.toString()));
    }
  }

  void signup(String? name, String email, String password, String otp) async {
    try {
      emit(AuthLoadingState());
      if (type == USER_ROLES.company) {
        await _companyRepository.companySignup(email, password, otp);
      } else {
        if (name == null) throw Exception("Name is required");
        await _traderRepository.signup(name, email, password, otp);
      }
      emit(AuthLoggedInState());
    } catch (ex) {
      emit(AuthErrorState(ex.toString()));
    }
  }

  void login(String email, String password) async {
    try {
      emit(AuthLoadingState());
      if (type == USER_ROLES.company) {
        await _companyRepository.companyLogin(email, password);
      } else {
        await _traderRepository.login(email, password);
      }
      emit(AuthLoggedInState());
    } catch (ex) {
      emit(AuthErrorState(ex.toString()));
    }
  }

  void logout() async {
    try {
      emit(AuthLoadingState());
      await _authRepository.logoutUser();
      emit(AuthLoggedOutState());
    } catch (ex) {
      emit(AuthErrorState(ex.toString()));
    }
  }
}
