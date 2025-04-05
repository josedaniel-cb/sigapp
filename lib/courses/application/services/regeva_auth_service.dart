import 'package:sigapp/courses/application/dtos/regeva_auth_tokens_dto.dart';

abstract class RegevaAuthService {
  Future<RevegaAuthCredentialsDto> getCredentials([bool? refresh]);
}
