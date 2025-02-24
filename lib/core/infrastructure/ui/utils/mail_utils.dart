import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MailUtils {
  static void launchEmail(
    BuildContext context, {
    required String email,
    required String subject,
    String? body,
  }) async {
    // iOS: you need to ios/Runner/Info.plist
    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body ?? '',
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
