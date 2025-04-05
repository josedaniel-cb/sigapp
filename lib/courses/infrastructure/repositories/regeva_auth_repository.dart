import 'package:injectable/injectable.dart';
import 'package:sigapp/core/infrastructure/http/siga_client.dart';
import 'package:sigapp/courses/application/dtos/regeva_auth_tokens_dto.dart';
import 'package:sigapp/courses/application/repositories/regeva_auth_repository.dart';
import 'package:html/parser.dart' as htmlParser;

@LazySingleton(as: RegevaAuthRepository)
class RegevaAuthRepositoryImpl implements RegevaAuthRepository {
  final SigaClient _sigaClient;

  RegevaAuthRepositoryImpl(this._sigaClient);

  @override
  Future<RevegaAuthCredentialsDto> fetchCredentials() async {
    final response1 = await _sigaClient.http.get('/Academico/Boletin');
    final pageSource = response1.data as String;

    // Get tokens
    final regex = RegExp(r'token1=(.*?)&amp;token2=(.*?)&amp;ip=');
    final match = regex.firstMatch(pageSource);

    if (match == null) {
      throw Exception('Regeva tokens not found');
    }
    final token1 = match.group(1);
    if (token1 == null) throw Exception('Token1 not found');
    final token2 = match.group(2);
    if (token2 == null) throw Exception('Token2 not found');

    // Get student code
    final html = htmlParser.parse(pageSource);
    final parts =
        html.querySelectorAll('dd').map((e) => e.text.trim()).toList();
    final studentCode = parts[0].split(' - ')[0];
    if (studentCode.isEmpty) throw Exception('Student code not found');

    return RevegaAuthCredentialsDto(
      studentCode: studentCode,
      token1: token1,
      token2: token2,
    );
  }
}
