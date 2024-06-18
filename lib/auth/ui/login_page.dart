import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/auth/auth_service.dart';
import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                ElevatedButton(
                  child: state is LoadingState
                      ? CircularProgressIndicator()
                      : Text('Login'),
                  onPressed: state is LoadingState
                      ? null
                      : () => context.read<LoginCubit>().login(
                            _usernameController.text,
                            _passwordController.text,
                          ),
                ),
                if (state is ErrorState)
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is SuccessState) {
            getIt<AuthService>().saveToken('aux');
            getIt<GoRouter>().push('/');
          }
        },
      ),
    );
  }
}
