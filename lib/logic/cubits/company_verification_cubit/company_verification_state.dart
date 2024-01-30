abstract class CompanyVerificationState {}

class CompanyVerificationInitialState extends CompanyVerificationState {}

class CompanyVerificationLoadingState extends CompanyVerificationState {}

class CompanyVerificationErrorState extends CompanyVerificationState {
  final String message;
  CompanyVerificationErrorState(this.message);
}

class CompanyVerificationPendingState extends CompanyVerificationState {}

class CompanyVerificationOngoingState extends CompanyVerificationState {
  final String status;
  final String? remark;
  CompanyVerificationOngoingState({required this.status, this.remark});
}

class CompanyVerificationCompleteState extends CompanyVerificationState {}
