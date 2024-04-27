import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_state.dart';
import 'package:cargo_linker/presentation/widgets/primary_table.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyDetailsTab extends StatelessWidget {
  const CompanyDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyVerificationCubit, CompanyVerificationState>(
      builder: (context, state) {
        if (state is CompanyVerificationCompleteState) {
          DateTime establishmentDate =
              DateTime.parse(state.companyDetails.establishmentDate);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: Icon(
                      SERVICE_TYPES_ICON[state.companyDetails.serviceType],
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  const Spacing(
                    multiply: 1,
                  ),
                  Text(
                    state.companyDetails.name,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2),
                  ),
                ],
              ),
              const Spacing(),
              Center(
                child: Text(
                  state.companyDetails.email,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const Spacing(
                multiply: 3,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: PrimaryTable(
                    tableData: {
                      "Established on:":
                          "${establishmentDate.day}/${establishmentDate.month}/${establishmentDate.year}",
                      "Registration no:":
                          state.companyDetails.registrationNumber,
                      "Service Type:": state.companyDetails.serviceType,
                      "Listed Containers":
                          state.companyDetails.listedContainers.toString(),
                      "Total Bookings":
                          state.companyDetails.totalBookings.toString(),
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
