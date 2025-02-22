import 'package:flutter/material.dart';
import 'package:sigapp/core/ui/widgets/brand_text.dart';
import 'package:sigapp/core/ui/widgets/initials_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralAvatarDialog extends StatelessWidget {
  const GeneralAvatarDialog(
      {super.key,
      required this.userFirstNameInitials,
      required this.userFullName,
      required this.userId,
      this.errorMessage,
      required this.onSignOut});

  final String userFirstNameInitials;
  final String userFullName;
  final String userId;
  final String? errorMessage;
  final void Function() onSignOut;

  @override
  Widget build(BuildContext context) {
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
                        enableGradient: true,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      title: Text(userFullName),
                      subtitle: Text(userId),
                    ),
                    if (errorMessage != null)
                      ListTile(
                        subtitle: Text(
                          errorMessage!,
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
