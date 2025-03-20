import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/core/infrastructure/ui/links.dart';
import 'package:sigapp/core/infrastructure/ui/utils/mail_utils.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/brand_text.dart';
import 'package:sigapp/shared/infrastructure/pages/easter_egg_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPageWidget extends StatelessWidget {
  const AboutPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: ListView(children: [
        ListTile(
          title: GestureDetector(
            onLongPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EasterEggPageWidget(),
                ),
              );
            },
            child: BrandTextWidget(
              fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
            ),
          ),
          // subtitle: Text('Universidad Nacional de Piura'),
        ),
        ListTile(
          leading: Icon(MdiIcons.github),
          title: Text('GitHub del proyecto'),
          onTap: () =>
              _launchUrl(context, 'https://github.com/josedaniel-cb/sigapp'),
        ),
        ListTile(
          leading: Icon(MdiIcons.handshake),
          title: Text('¿Eres desarrollador?'),
          subtitle: Text('Conviértete contribuyente'),
          onTap: () {
            MailUtils.launchEmail(
              context,
              email: Links.contactEmail,
              subject: 'Hola! Quiero contribuir al proyecto',
            );
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            'Enlaces útiles',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        _buildLinkListTile(
          context,
          title: 'SIGA',
          url: 'https://academico.unp.edu.pe/',
        ),
        _buildLinkListTile(
          context,
          title: 'Reporte pagos',
          url: 'http://pagos.unp.edu.pe/ReportePagos/',
        ),
        _buildLinkListTile(
          context,
          title: 'Recuperar contraseña',
          url: 'https://academico.unp.edu.pe/Cuenta/ResetPassword',
        ),
        Divider(),
      ]),
    );
  }

  Widget _buildLinkListTile(
    BuildContext context, {
    required String title,
    required String url,
  }) {
    return ListTile(
      // leading: EmptyIconWidget(),
      leading: Icon(MdiIcons.web),
      title: Text(title),
      // trailing: Icon(Icons.open_in_new),
      onTap: () => _launchUrl(context, url),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo abrir el enlace'),
        ),
      );
    }
  }
}
