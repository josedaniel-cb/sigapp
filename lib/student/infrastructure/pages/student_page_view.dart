import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/student/infrastructure/pages/student_cubit.dart';

class StudentPageView extends StatefulWidget {
  const StudentPageView({super.key});

  @override
  State<StudentPageView> createState() => _StudentPageViewState();
}

class _StudentPageViewState extends State<StudentPageView> {
  late final StudentPageViewCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<StudentPageViewCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.setup();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentPageViewCubit, StudentPageViewState>(
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
    );
  }

  SingleChildScrollView _buildSuccessState(
    BuildContext context,
    SuccessState state,
  ) {
    final info = state.academicReport;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(info.toString()),
          // ListTile(
          //   title: const Text('Horario'),
          //   onTap: () {
          //     getIt<GoRouter>().push('/schedule');
          //   },
          // ),
          // ListTile(
          //   title: const Text('Cerrar sesión'),
          //   onTap: () => _cubit.logout(context),
          // ),
        ],
      ),
    );
  }
}
