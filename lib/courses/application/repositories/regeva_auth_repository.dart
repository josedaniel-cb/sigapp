import 'package:sigapp/courses/application/dtos/regeva_auth_tokens_dto.dart';

abstract class RegevaAuthRepository {
  Future<RevegaAuthCredentialsDto> fetchCredentials();
}
