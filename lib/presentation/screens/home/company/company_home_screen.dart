import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/logic/cubits/company_cubit/company_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_cubit/company_state.dart';
import 'package:cargo_linker/presentation/screens/company_list_container/company_list_container.dart';
import 'package:cargo_linker/presentation/screens/home/company/company_bookings_tab.dart';
import 'package:cargo_linker/presentation/screens/home/company/company_containers_tab.dart';
import 'package:cargo_linker/presentation/screens/home/company/company_details_tab.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  static const String routeName = "companyHome";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CompanyCubit>(context).switchToBookings();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: BlocListener<CompanyCubit, CompanyState>(
        listener: (context, state) {
          if (state is CompanyErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<CompanyCubit, CompanyState>(
          builder: (context, state) {
            int pageIndex = state is CompanyBookingsScreenState
                ? 0
                : state is CompanyContainersScreenState
                    ? 1
                    : 2;

            final Widget screenWidget = state is CompanyBookingsScreenState
                ? CompanyBookingsTab(bookings: state.bookings)
                : state is CompanyContainersScreenState
                    ? CompanyContainersTab(containers: state.containers)
                    : const CompanyDetailsTab();

            return Scaffold(
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
              bottomNavigationBar: NavigationBar(
                selectedIndex: pageIndex,
                onDestinationSelected: (value) {
                  if (value == 0) {
                    BlocProvider.of<CompanyCubit>(context).switchToBookings();
                  }
                  if (value == 1) {
                    BlocProvider.of<CompanyCubit>(context).switchToContainers();
                  }
                  if (value == 2) {
                    BlocProvider.of<CompanyCubit>(context).switchToDetails();
                  }
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.event),
                    label: "Bookings",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.directions_boat),
                    label: "Listed Containers",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.info_outline_rounded),
                    label: "Company Details",
                  ),
                ],
              ),
              floatingActionButton: pageIndex == 1
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CompanyListContainerScreen.routeName);
                      },
                      label: const Row(
                        children: [
                          Icon(Icons.add),
                          Spacing(),
                          Text("Add Container"),
                        ],
                      ),
                    )
                  : null,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: screenWidget,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
