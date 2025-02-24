import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
            onDoubleTap: () {
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
            _launchEmail(
              context,
              email: 'jose.daniel.calle.brice@gmail.com',
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

  void _launchEmail(
    BuildContext context, {
    required String email,
    required String subject,
  }) async {
    // iOS: you need to ios/Runner/Info.plist
    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        // 'body': 'Hola, este es un mensaje prellenado.',
      },
    );

    try {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error al abrir el correo'),
        ),
      );
    }
  }
}
