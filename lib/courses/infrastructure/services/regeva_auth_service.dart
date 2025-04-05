import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/dtos/regeva_auth_tokens_dto.dart';
import 'package:sigapp/courses/application/repositories/regeva_auth_repository.dart';
import 'package:sigapp/courses/application/services/regeva_auth_service.dart';

@LazySingleton(as: RegevaAuthService)
class RegevaAuthServiceImpl implements RegevaAuthService {
  final RegevaAuthRepository _regevaAuthRepository;

  RevegaAuthCredentialsDto? _cachedCredentials;

  RegevaAuthServiceImpl(this._regevaAuthRepository);

  @override
  Future<RevegaAuthCredentialsDto> getCredentials([bool? refresh]) async {
    if (refresh != true && _cachedCredentials != null) {
      return _cachedCredentials!;
    }
    final value = await _regevaAuthRepository.fetchCredentials();
    _cachedCredentials = value;
    return value;
  }
}
