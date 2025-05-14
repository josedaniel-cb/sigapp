import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/shared/infrastructure/partials/user_avatar_button/general_alert_dialog.dart';
import 'package:sigapp/shared/infrastructure/partials/user_avatar_button_cubit.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/initials_avatar.dart';
import 'package:sigapp/student/domain/value_objects/academic_info_data.dart';

class UserAvatarButtonWidget extends StatelessWidget {
  const UserAvatarButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<UserAvatarButtonCubit>(),
      child: BlocBuilder<UserAvatarButtonCubit, UserAvatarButtonState>(
        builder: (context, state) {
          return state.map(
            initial: (_) {
              BlocProvider.of<UserAvatarButtonCubit>(context).init();
              return _buildCircularProgressIndicator();
            },
            loading: (_) => _buildCircularProgressIndicator(),
            success: (s) => _build(context, s),
            error: (s) => _build(context, s),
          );
        },
      ),
    );
  }

  Widget _buildCircularProgressIndicator() {
    return const SizedBox(
      height: 32,
      width: 32,
      child: CircularProgressIndicator(),
    );
  }

  Widget _build(BuildContext context, UserAvatarButtonState state) {
    final academicProgram = state.mapOrNull(
      success: (s) => s.data.academicProgram,
    );

    final userData = _extractUserData(state);
    final cubit = BlocProvider.of<UserAvatarButtonCubit>(context);

    if (academicProgram != null) {
      final imageFilePath = _getCareerImagePath(academicProgram);
      return _buildAvatar(
        context: context,
        imageFilePath: imageFilePath,
        initials: null,
        userData: userData,
        cubit: cubit,
      );
    }

    return _buildAvatar(
      context: context,
      imageFilePath: null,
      initials: userData.initials,
      userData: userData,
      cubit: cubit,
    );
  }

  _UserData _extractUserData(UserAvatarButtonState state) {
    var initials = '?';
    var fullName = 'Desconocido';
    var id = 'Desconocido';
    String? errorMessage;

    state.mapOrNull(
      success: (state) {
        initials =
            state.data.academicReport.firstName
                .split(' ')
                .map((w) => w.characters.first.toUpperCase())
                .take(2)
                .join();
        fullName =
            '${state.data.academicReport.firstName} ${state.data.academicReport.lastName}';
        id = state.data.academicReport.code;
        errorMessage = state.errorMessage;
      },
      error: (state) {
        if (state.error != null) {
          errorMessage = state.error.toString();
        }
      },
    );

    return _UserData(
      initials: initials,
      fullName: fullName,
      id: id,
      errorMessage: errorMessage,
    );
  }

  Widget _buildAvatar({
    required BuildContext context,
    required String? imageFilePath,
    required String? initials,
    required _UserData userData,
    required UserAvatarButtonCubit cubit,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Si tenemos una ruta de imagen, creamos un avatar con imagen
    if (imageFilePath != null) {
      return AvatarCircleWidget(
        imageFilePath: imageFilePath,
        fallbackContent: null,
        backgroundColor: primaryColor,
        onTap:
            () => _showAvatarDialog(
              context: context,
              imageFilePath: imageFilePath,
              initials: null,
              userData: userData,
              cubit: cubit,
            ),
      );
    }

    // Si no tenemos imagen, creamos un avatar con iniciales
    return InitialsAvatarWidget(
      backgroundColor: primaryColor,
      content: initials ?? '?',
      enableGradient: true,
      onPressed:
          () => _showAvatarDialog(
            context: context,
            imageFilePath: null,
            initials: initials,
            userData: userData,
            cubit: cubit,
          ),
    );
  }

  void _showAvatarDialog({
    required BuildContext context,
    required String? imageFilePath,
    required String? initials,
    required _UserData userData,
    required UserAvatarButtonCubit cubit,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GeneralAvatarDialog(
          avatar: AvatarCircleWidget(
            imageFilePath: imageFilePath,
            fallbackContent: initials,
            backgroundColor: primaryColor,
          ),
          userFullName: userData.fullName,
          userId: userData.id,
          errorMessage: userData.errorMessage,
          onSignOut: () {
            Navigator.of(context).pop();
            cubit.signOut();
          },
        );
      },
    );
  }

  String _getCareerImagePath(AcademicProgram academicProgram) {
    switch (academicProgram) {
      case AcademicProgram.administration:
        return 'assets/img/administracion.png';
      case AcademicProgram.agricultural:
        return 'assets/img/agricola.png';
      case AcademicProgram.agroindustrialFood:
        return 'assets/img/agroindustrial_alimentaria.png';
      case AcademicProgram.agronomy:
        return 'assets/img/agronomia.png';
      case AcademicProgram.environmental:
        return 'assets/img/ambiental.png';
      case AcademicProgram.architecture:
        return 'assets/img/arquitectura.png';
      case AcademicProgram.biology:
        return 'assets/img/biologia.png';
      case AcademicProgram.civil:
        return 'assets/img/civil.png';
      case AcademicProgram.communication:
        return 'assets/img/comunicacion.png';
      case AcademicProgram.accounting:
        return 'assets/img/contabilidad.png';
      case AcademicProgram.law:
        return 'assets/img/derecho.png';
      case AcademicProgram.economics:
        return 'assets/img/economia.png';
      case AcademicProgram.initialEducation:
        return 'assets/img/educacion_inicial.png';
      case AcademicProgram.primaryEducation:
        return 'assets/img/educacion_primaria.png';
      case AcademicProgram.electronic:
        return 'assets/img/electronica.png';
      case AcademicProgram.nursing:
        return 'assets/img/enfermeria.png';
      case AcademicProgram.statistics:
        return 'assets/img/estadistica.png';
      case AcademicProgram.stomatology:
        return 'assets/img/estomatologia.png';
      case AcademicProgram.physics:
        return 'assets/img/fisica.png';
      case AcademicProgram.geological:
        return 'assets/img/geologica.png';
      case AcademicProgram.historyGeography:
        return 'assets/img/historia_y_geografia.png';
      case AcademicProgram.industrial:
        return 'assets/img/industrial.png';
      case AcademicProgram.informatics:
        return 'assets/img/informatica.png';
      case AcademicProgram.languageLiterature:
        return 'assets/img/lengua_y_literatura.png';
      case AcademicProgram.mathematics:
        return 'assets/img/matematica.png';
      case AcademicProgram.mechatronics:
        return 'assets/img/mecatronica.png';
      case AcademicProgram.medicine:
        return 'assets/img/medicina.png';
      case AcademicProgram.mining:
        return 'assets/img/minas.png';
      case AcademicProgram.obstetrics:
        return 'assets/img/obstetricia.png';
      case AcademicProgram.fishing:
        return 'assets/img/pesquera.png';
      case AcademicProgram.petroleum:
        return 'assets/img/petroleo.png';
      case AcademicProgram.psychology:
        return 'assets/img/psicologia.png';
      case AcademicProgram.chemistry:
        return 'assets/img/quimica.png';
      case AcademicProgram.veterinary:
        return 'assets/img/veterinaria.png';
      case AcademicProgram.zootechnics:
        return 'assets/img/zootecnia.png';
    }
  }
}

class _UserData {
  final String initials;
  final String fullName;
  final String id;
  final String? errorMessage;

  _UserData({
    required this.initials,
    required this.fullName,
    required this.id,
    this.errorMessage,
  });
}
