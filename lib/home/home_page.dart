import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/home/home_cubit.dart';

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
    // After render hook
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
      body: BlocConsumer<HomeCubit, HomeState>(builder: (context, state) {
        return state.map(
          loading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          success: (state) => SingleChildScrollView(
            child: Column(
              children: [
                Text(state.academicReport.toString()),
                ElevatedButton(
                  onPressed: () => _cubit.logout(context),
                  child: Text('Cerrar sesión'),
                ),
              ],
            ),
          ),
          error: (state) => Center(
            child: Column(
              children: [
                Text(state.message),
                ElevatedButton(
                  onPressed: _cubit.setup,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is SuccessState) {
          // Do something
        } else if (state is ErrorState) {
          // Do something
        }
      }),
    );
  }
}
