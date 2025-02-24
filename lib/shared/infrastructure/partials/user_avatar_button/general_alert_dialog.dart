import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/core/infrastructure/ui/links.dart';
import 'package:sigapp/core/infrastructure/ui/utils/mail_utils.dart';
import 'package:sigapp/core/infrastructure/ui/utils/share_utils.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/brand_text.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/empty_icon.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/initials_avatar.dart';
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
                      leading: Icon(Icons.share),
                      title: Text('Compartir'),
                      onTap: () {
                        Navigator.of(context).pop();

                        ShareUtils.shareAssetsFile(
                          context,
                          assetPath: 'assets/share.png',
                          mimeType: 'image/png',
                          name: 'share.png',
                          text:
                              'Unepino, descarga la app del SIGA (no oficial) desde el siguiente enlace: '
                              '${Links.playStoreUrl}\n'
                              '👌\tBon appetit',
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.bug_report),
                      title: Text('Reportar un problema'),
                      onTap: () {
                        Navigator.of(context).pop();
                        MailUtils.launchEmail(
                          context,
                          email: Links.contactEmail,
                          subject: 'Hola! Quiero reportar un error',
                          body: '(agrega capturas de pantalla)',
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('Acerca de'),
                      onTap: () {
                        Navigator.of(context).pop();
                        GoRouter.of(context).push('/about');
                      },
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
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildFooter(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(
          context, 'https://josedaniel-cb.github.io/sigapp-privacy-policy/'),
      child: Text(
        'Política de privacidad',
        style: Theme.of(context).textTheme.bodySmall,
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
