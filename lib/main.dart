import 'dart:developer';
import 'package:cargo_linker/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_verification_cubit/company_verification_cubit.dart';
import 'package:cargo_linker/logic/cubits/trader_container_search_cubit/trader_container_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cargo_linker/core/ui.dart';
import 'package:cargo_linker/core/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cargo_linker/presentation/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  runApp(const CargoLinkerApp());
}

class CargoLinkerApp extends StatelessWidget {
  const CargoLinkerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CompanyVerificationCubit()),
        BlocProvider(create: (context) => CompanyContainerCubit()),
        BlocProvider(create: (context) => TraderContainerBookingCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
