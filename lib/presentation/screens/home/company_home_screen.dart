import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_state.dart';
import 'package:cargo_linker/presentation/screens/company_list_container/company_list_container.dart';
import 'package:cargo_linker/presentation/screens/home/container_card.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:cargo_linker/presentation/widgets/primary_button.dart';
import 'package:cargo_linker/presentation/widgets/primary_table.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  static const String routeName = "companyHome";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CompanyContainerCubit>(context).getListedContainers();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: BlocListener<CompanyContainerCubit, CompanyContainerState>(
        listener: (context, state) {
          if (state is CompanyContainerErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is CompanyContainerListedState) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("HOME"),
            centerTitle: false,
            actions: [
              IconButton(onPressed: () {
                BlocProvider.of<AuthCubit>(context).logout();
              }, icon: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return const Icon(Icons.logout);
                },
              )),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Company Details",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Spacing(multiply: 1),
                  Card(
                    child: PrimaryTable(
                      tableData: TEST_COMPANY,
                    ),
                  ),
                  const Spacing(multiply: 4),
                  const Text(
                    "Listed Containers",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Spacing(multiply: 2),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, CompanyListContainerScreen.routeName);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Spacing(),
                        Text("Add Container")
                      ],
                    ),
                  ),
                  const Spacing(
                    multiply: 2,
                  ),
                  BlocBuilder<CompanyContainerCubit, CompanyContainerState>(
                    builder: (context, state) {
                      if (state is CompanyContainerLoadingState) {
                        return const Center(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }

                      if (state is CompanyContainerListedState) {
                        return Column(
                          children: state.containers.reversed
                              .map((container) => Column(
                                    children: [
                                      ContainerCard(
                                        container: container,
                                      ),
                                      const Spacing(
                                        multiply: 2,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
