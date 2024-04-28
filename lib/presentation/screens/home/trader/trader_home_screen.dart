import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_state.dart';
import 'package:cargo_linker/logic/cubits/trader_cubit/trader_cubit.dart';
import 'package:cargo_linker/logic/cubits/trader_cubit/trader_state.dart';
import 'package:cargo_linker/presentation/screens/home/trader/trader_bookings_tab.dart';
import 'package:cargo_linker/presentation/screens/home/trader/trader_search_tab.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraderHomeScreen extends StatelessWidget {
  const TraderHomeScreen({super.key});

  static const String routeName = "traderHome";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TraderCubit>(context).switchToBookings();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: BlocListener<TraderCubit, TraderState>(
        listener: (context, state) {
          if (state is TraderErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<TraderCubit, TraderState>(
          builder: (context, state) {
            int pageIndex = state is TraderSearchScreenState ? 1 : 0;

            final Widget screenWidget = state is TraderBookingsScreenState
                ? TraderBookingsTab(bookings: state.bookings)
                : TraderSearchTab();

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
                    BlocProvider.of<TraderCubit>(context).switchToBookings();
                  } else {
                    BlocProvider.of<TraderCubit>(context).switchToSearch();
                  }
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.event),
                    label: "My Bookings",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search),
                    label: "Search Containers",
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
