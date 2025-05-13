import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sigapp/core/infrastructure/ui/links.dart';
import 'package:sigapp/core/infrastructure/ui/utils/mail_utils.dart';

class ReportProblemPage extends StatelessWidget {
  const ReportProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Algo falló? 😓',
                      style: textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Esta app no es oficial. Es un side project que mantengo en mi tiempo libre.\n\n'
                      'Si algo salió mal, reporta el error. Si es urgente, lo arreglaré lo antes posible.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Lottie.asset(
                      'assets/lottie/collaboration.json',
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '💡 Consejo: antes de poner menos de 5 estrellas, escríbeme.\n'
                      'Tu feedback directo mejora la app. Las estrellas sin contexto no ayudan 😢',
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Button to launch email
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    MailUtils.launchEmail(
                      context,
                      email: Links.contactEmail,
                      subject: 'Hola! Quiero reportar un error',
                      body: '(agrega capturas de pantalla o contexto)',
                    );
                  },
                  icon: const Icon(Icons.bug_report),
                  label: const Text('Reportar problema'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
