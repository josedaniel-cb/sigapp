import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/ui/pages/partials/user_avatar_button_cubit.dart';
import 'package:sigapp/core/ui/widgets/brand_text.dart';
import 'package:sigapp/core/ui/widgets/initials_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class UserAvatarButtonWidget extends StatelessWidget {
  const UserAvatarButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<UserAvatarButtonCubit>();
    return BlocBuilder<UserAvatarButtonCubit, UserAvatarButtonState>(
      bloc: cubit,
      builder: (context, state) {
        return state.map(
          empty: (_) {
            cubit.init();
            return _buildCircularProgressIndicator();
          },
          loading: (_) => _buildCircularProgressIndicator(),
          success: (s) => _buildAvatar(context, s),
          error: (s) => _buildAvatar(context, s),
        );
      },
    );
  }

  Widget _buildCircularProgressIndicator() {
    return SizedBox(
      height: 32,
      width: 32,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildAvatar(BuildContext context, UserAvatarButtonState state) {
    var userFirstNameInitials = '?';
    var userFullName = 'Desconocido';
    var userId = 'Desconocido';
    String? errorMessage;
    state.mapOrNull(
      success: (state) {
        userFirstNameInitials = state.data.firstName
            .split(' ')
            .map((w) => w.characters.first.toUpperCase())
            .take(2)
            .join();
        userFullName = '${state.data.firstName} ${state.data.lastName}';
        userId = state.data.code;
      },
      error: (state) {
        if (state.error != null) {
          errorMessage = state.error.toString();
        }
      },
    );

    return InitialsAvatarWidget(
      backgroundColor: Theme.of(context).primaryColor,
      content: userFirstNameInitials,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildAlertDialog(
              context,
              userFirstNameInitials: userFirstNameInitials,
              userFullName: userFullName,
              userId: userId,
              errorMessage: errorMessage,
              onSignOut: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAlertDialog(
    BuildContext context, {
    required String userFirstNameInitials,
    required String userFullName,
    required String userId,
    required String? errorMessage,
    required void Function() onSignOut,
  }) {
    return AlertDialog(
      title: Stack(
        children: [
          Center(
            child: BrandTextWidget(
              fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 8,
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: InitialsAvatarWidget(
                        content: userFirstNameInitials,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      title: Text(userFullName),
                      subtitle: Text(userId),
                    ),
                    // Error message
                    if (errorMessage != null)
                      ListTile(
                        subtitle: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Cerrar sesión'),
                      onTap: () {
                        onSignOut();
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: TextButton(
            //     onPressed: onSignOut,
            //     child: Text('Cerrar sesión'),
            //   ),
            // ),
            GestureDetector(
              onTap: () => _launchUrl(context,
                  'https://josedaniel-cb.github.io/sigapp-privacy-policy/'),
              child: Text(
                'Política de privacidad',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo abrir el enlace'),
        ),
      );
    }
  }
}
