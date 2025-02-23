import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/ui/partials/user_avatar_button/general_alert_dialog.dart';
import 'package:sigapp/core/ui/partials/user_avatar_button_cubit.dart';
import 'package:sigapp/core/ui/widgets/initials_avatar.dart';

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
    return SizedBox(
      height: 32,
      width: 32,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _build(BuildContext context, UserAvatarButtonState state) {
    var userFirstNameInitials = '?';
    var userFullName = 'Desconocido';
    var userId = 'Desconocido';
    String? errorMessage;
    state.mapOrNull(
      success: (state) {
        userFirstNameInitials = state.data.firstName
            .split(' ')
            .map((w) => w.characters.first.toUpperCase())
            .take(2)
            .join();
        userFullName = '${state.data.firstName} ${state.data.lastName}';
        userId = state.data.code;
        errorMessage = state.errorMessage;
      },
      error: (state) {
        if (state.error != null) {
          errorMessage = state.error.toString();
        }
      },
    );

    final cubit = BlocProvider.of<UserAvatarButtonCubit>(context);

    return InitialsAvatarWidget(
      backgroundColor: Theme.of(context).primaryColor,
      content: userFirstNameInitials,
      enableGradient: true,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GeneralAvatarDialog(
              userFirstNameInitials: userFirstNameInitials,
              userFullName: userFullName,
              userId: userId,
              errorMessage: errorMessage,
              onSignOut: () {
                Navigator.of(context).pop();
                cubit.signOut();
              },
            );
          },
        );
      },
    );
  }
}
