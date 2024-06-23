import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/app/get_it.dart';
// import 'package:sigapp/auth/auth_service.dart';
import 'login_cubit.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginCubit>().setup();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          final status = state.status;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: status is LoginLoading
                      ? null
                      : () => context.read<LoginCubit>().login(
                            _usernameController.text,
                            _passwordController.text,
                          ),
                  child: status is LoginLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
                if (status is LoginError)
                  Text(
                    status.message,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.username.isNotEmpty &&
              _usernameController.text != state.username) {
            _usernameController.text = state.username;
          }
          if (state.password.isNotEmpty &&
              _passwordController.text != state.password) {
            _passwordController.text = state.password;
          }

          final status = state.status;
          if (status is LoginSuccess) {
            // getIt<AuthService>().saveToken('aux');
            getIt<GoRouter>().pushReplacement('/');
          }
        },
      ),
    );
  }
}
