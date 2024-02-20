import 'package:cargo_linker/data/constants/company.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/presentation/screens/company_list_container/company_list_container.dart';
import 'package:cargo_linker/presentation/screens/home/company_home_container_card.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
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
                LISTED_CONTAINERS.isEmpty
                    ? Column(
                        children: [
                          const Spacing(
                            multiply: 2,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              "No containers listed yet",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: LISTED_CONTAINERS
                            .map((container) => Column(
                                  children: [
                                    CompanyHomeScreenContainerCard(
                                      containerId: container["containerId"],
                                      dimension: container["dimension"],
                                      drop: container["drop"],
                                      due: container["due"],
                                      pickup: container["pickup"],
                                      price: container["price"],
                                      size: container["size"],
                                      type: container["type"],
                                    ),
                                    const Spacing(
                                      multiply: 2,
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
