import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

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
      query: {
        'subject': Uri.encodeComponent(subject),
        'body': Uri.encodeComponent(body ?? ''),
      }.entries.map((e) => '${e.key}=${e.value}').join('&'),
    );

    try {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e, s) {
      developer.log(
        'Error launching email app: $e',
        name: 'MailUtils',
        error: e,
        stackTrace: s,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error al abrir el correo'),
        ),
      );
    }
  }
}
