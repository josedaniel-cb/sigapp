import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/auth/infrastructure/pages/welcome_page.dart';
import 'package:sigapp/core/infrastructure/ui/links.dart';
import 'package:sigapp/core/infrastructure/ui/utils/mail_utils.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/brand_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginCubit>().setup();
      // showDearStudentDialog(context);
      // push WelcomePage
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() {
    context.read<LoginCubit>().login(
          _usernameController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          final status = state.status;
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const BrandTextWidget(fontSize: 40),
                              // Text(
                              //   'Beta',
                              //   style:
                              //       Theme.of(context).textTheme.bodyLarge?.copyWith(
                              //             color: Colors.red,
                              //           ),
                              // )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _usernameController,
                                  focusNode: _usernameFocusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Usuario',
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Contraseña',
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(),
                                  ),
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) {
                                    if (status is! LoginLoading) {
                                      _login();
                                    }
                                  },
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed:
                                        status is LoginLoading ? null : _login,
                                    child: status is LoginLoading
                                        ? const SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text(
                                            'Ingresar',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (status is LoginError)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                status.message,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                // spacing: 8.0, // Espacio horizontal entre widgets
                runSpacing: 0, // Espacio vertical entre líneas
                children: [
                  TextButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse(Links.privacyPolicyUrl),
                          mode: LaunchMode.externalApplication);
                    },
                    // icon: Icon(MdiIcons.web),
                    label: const Text('Política de privacidad'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse(Links.projectUrl),
                          mode: LaunchMode.externalApplication);
                    },
                    icon: Icon(MdiIcons.github),
                    label: const Text('Proyecto'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      MailUtils.launchEmail(context, email: Links.contactEmail);
                    },
                    // icon: Icon(MdiIcons.handshake),
                    label: const Text('Contacto'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
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
            getIt<GoRouter>().pushReplacement('/');
          }
        },
      ),
    );
  }
}
