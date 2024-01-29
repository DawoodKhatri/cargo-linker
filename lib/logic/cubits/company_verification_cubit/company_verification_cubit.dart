import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/data/repositories/company_repository.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyVerificationCubit extends Cubit<CompanyVerificationState> {
  CompanyVerificationCubit() : super(CompanyVerificationInitialState());

  final _companyRepository = CompanyRepository();

  void checkVerification() async {
    try {
      emit(CompanyVerificationLoadingState());
      Map<String, dynamic> verification =
          await _companyRepository.companyVerificationStatus();

      if (verification["status"] == VERIFICATION_STATUS.incomplete) {
        emit(CompanyVerificationPendingState());
      } else if (verification["status"] ==
              VERIFICATION_STATUS.underVerification ||
          verification["status"] == VERIFICATION_STATUS.rejected) {
        emit(
          CompanyVerificationOngoingState(
            status: verification["status"],
            message: verification["message"],
          ),
        );
      } else {
        emit(CompanyVerificationCompleteState());
      }
    } catch (e) {
      emit(CompanyVerificationErrorState(e.toString()));
    }
  }

  void submitDetails(
      String name,
      String establishmentDate,
      String registrationNumber,
      String serviceType,
      String licensePath,
      String bankStatementPath) async {
    try {
      emit(CompanyVerificationLoadingState());
      await _companyRepository.companySubmitVerification(
          name,
          establishmentDate,
          registrationNumber,
          serviceType,
          licensePath,
          bankStatementPath);

      Map<String, dynamic> verification =
          await _companyRepository.companyVerificationStatus();

      emit(CompanyVerificationOngoingState(
          status: verification["status"], message: verification["message"]));
    } catch (e) {
      emit(CompanyVerificationErrorState(e.toString()));
    }
  }
}
