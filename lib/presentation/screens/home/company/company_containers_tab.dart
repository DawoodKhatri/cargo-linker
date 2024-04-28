import 'package:cargo_linker/data/repositories/container_repository.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_container_cubit/company_container_state.dart';
import 'package:cargo_linker/logic/cubits/company_cubit/company_cubit.dart';
import 'package:cargo_linker/logic/cubits/company_cubit/company_state.dart';
import 'package:cargo_linker/presentation/screens/home/container_card.dart';
import 'package:cargo_linker/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyContainersTab extends StatelessWidget {
  const CompanyContainersTab({super.key, required this.containers});
  final List<CompanyContainer> containers;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyContainerCubit, CompanyContainerState>(
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
          BlocProvider.of<CompanyCubit>(context).switchToContainers();
        }
      },
      child: BlocBuilder<CompanyCubit, CompanyState>(
        builder: (context, state) {
          if (state is CompanyContainersScreenState && state.isLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Listed Containers",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacing(
                multiply: 3,
              ),
              ...containers.reversed
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
                  .toList()
            ],
          );
        },
      ),
    );
  }
}
