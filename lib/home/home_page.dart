import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/home/home_cubit.dart';
import 'package:sigapp/shared/error_state.dart';
import 'package:sigapp/shared/loading_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<HomeCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.setup();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.map(
            loading: (_) => const LoadingStateWidget(),
            success: (state) => _buildSuccessState(context, state),
            error: (state) => ErrorStateWidget(
              message: state.message,
              onRetry: () => _cubit.setup(),
            ),
          );
        },
        listener: (context, state) {
          if (state is SuccessState) {
            // Do something
          } else if (state is ErrorState) {
            // Do something
          }
        },
      ),
    );
  }

  SingleChildScrollView _buildSuccessState(
    BuildContext context,
    SuccessState state,
  ) {
    // This has:
    // required String Facultad,
    // required String NomAlumno,
    // required String Promocion,
    // required String SemestreIngreso,
    // required String SemestrePlan,
    // required String? UltSemestre,
    // required double PPA,
    // required double PPAAprob,
    // required double UPPS,
    // required int TotalCredAprob,
    // required int CredObligPlan,
    // required int CredElectPlan,
    // required int CredObligAprob,
    // required int CredElectAprob,
    final info = state.academicReport;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(info.toString()),
          ListTile(
            title: const Text('Horario'),
            onTap: () {
              getIt<GoRouter>().push('/schedule');
            },
          ),
          ListTile(
            title: const Text('Cerrar sesión'),
            onTap: () => _cubit.logout(context),
          ),
        ],
      ),
    );
  }
}
