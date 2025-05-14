import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandTextWidget extends StatelessWidget {
  const BrandTextWidget({super.key, this.fontSize});

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'SIG',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
              ),
            ),
          ),
          TextSpan(
            text: 'App',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
