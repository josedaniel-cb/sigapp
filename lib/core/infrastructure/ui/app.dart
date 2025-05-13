import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/shared/infrastructure/overlays/progress_indicator_bloc.dart';
import 'package:sigapp/shared/infrastructure/overlays/progress_indicator_overlay.dart';
import 'package:sigapp/core/infrastructure/ui/theme/brand_theme.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProgressIndicatorBloc>()),
      ],
      child: ToastificationWrapper(
        child: MaterialApp.router(
          builder: (context, child) {
            return BlocBuilder<ProgressIndicatorBloc, ProgressIndicatorState>(
              builder: (context, state) {
                if (state is ProgressIndicatorHidden) return child!;
                return Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => Stack(
                        children: [
                          child!,
                          Positioned.fill(
                            child: ProgressIndicatorOverlayWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
          routerConfig: getIt<GoRouter>(),
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(BrandTheme.primaryColor),
              primary: Color(BrandTheme.primaryColor),
              secondary: Color(BrandTheme.secondaryColor),
              brightness: Brightness.light,
            ),
          ),
          // darkTheme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(
          //     seedColor: Color(BrandTheme.primaryColorDark),
          //     primary: Color(BrandTheme.primaryColorDark),
          //     secondary: Color(BrandTheme.secondaryColorDark),
          //     brightness: Brightness.dark,
          //     // background: Color(BrandTheme.backgroundColorDark), // deprecated
          //     surface: Color(BrandTheme.surfaceColorDark),
          //     error: Color(BrandTheme.errorColorDark),
          //   ),
          // ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(BrandTheme.primaryColor),
              primary: Color(BrandTheme.primaryColor),
              secondary: Color(BrandTheme.secondaryColor),
              brightness: Brightness.dark,
              // surface: Color(BrandTheme.surfaceColorDark),
              // error: Color(BrandTheme.errorColorDark),
            ),
          ),
        ),
      ),
    );
  }
}
