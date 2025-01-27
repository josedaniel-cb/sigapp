import 'package:sigapp/auth/application/usecases/keep_session_alive_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_in_usecase.dart';
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthUsecases {
  final SignInUseCase signIn;
  final GetStoredCredentialsUseCase getStoredCredentials;
  final SignOutUseCase signOut;
  final KeepSessionAliveUsecase keepSessionAlive;

  AuthUsecases(
    this.signIn,
    this.getStoredCredentials,
    this.signOut,
    this.keepSessionAlive,
  );
}
