import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/repositories/auth_repository.dart';
import 'package:sigapp/auth/domain/value-objects/api_response.dart';

@injectable
class KeepSessionAliveUsecase {
  final AuthRepository _authRepository;

  KeepSessionAliveUsecase(this._authRepository);

  Future<ApiResponse> execute() async {
    final response = await _authRepository.keepSession();
    return response;
  }
}
