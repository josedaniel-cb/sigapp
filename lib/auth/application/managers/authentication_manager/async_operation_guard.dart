import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

/// Garantiza que operaciones asíncronas críticas no se ejecuten simultáneamente
/// y permite que múltiples solicitantes compartan el resultado de una sola ejecución
@lazySingleton
class AsyncOperationGuard {
  final Logger _logger;

  /// Future que representa la operación en curso, si existe
  Future<dynamic>? _ongoingOperation;

  /// Identificador para depuración de la operación en curso
  String? _currentOperationDescription;

  AsyncOperationGuard(this._logger);

  /// Ejecuta una operación asegurando que no haya otra en progreso.
  /// Si hay una operación del mismo tipo en curso, espera a que termine y devuelve su resultado.
  ///
  /// [operationKey] es un identificador opcional para agrupar operaciones del mismo tipo.
  /// Si no se proporciona, cada llamada se considera una operación distinta.
  Future<T> executeSafely<T>(
    Future<T> Function() operation, {
    String? operationKey,
  }) async {
    final key =
        operationKey ?? 'anonymous-${DateTime.now().millisecondsSinceEpoch}';
    final description = 'Operación: $key';

    // Si hay una operación en curso y es del mismo tipo
    if (_ongoingOperation != null &&
        _currentOperationDescription == description) {
      _logger.d(
        '[INFRASTRUCTURE] Operación "$key" ya en progreso, esperando resultado compartido...',
      );

      try {
        // Esperar y devolver el resultado de la operación en curso
        // El cast es seguro porque verificamos que el tipo de operación es el mismo
        final result = await _ongoingOperation as T;
        _logger.d(
          '[INFRASTRUCTURE] Operación en progreso "$key" completada, devolviendo resultado compartido',
        );
        return result;
      } catch (e) {
        _logger.e(
          '[INFRASTRUCTURE] Operación en progreso "$key" falló, propagando error compartido: $e',
          error: e,
        );
        rethrow;
      }
    }

    // Si hay otra operación diferente en curso, esperar a que termine
    if (_ongoingOperation != null) {
      _logger.d(
        '[INFRASTRUCTURE] Operación diferente "$_currentOperationDescription" en progreso, esperando antes de iniciar "$key"...',
      );
      try {
        await _ongoingOperation;
        _logger.d(
          '[INFRASTRUCTURE] Operación previa completada, ahora ejecutando "$key"',
        );
      } catch (e) {
        _logger.w(
          '[INFRASTRUCTURE] Operación previa falló, ejecutando "$key" de todos modos',
        );
        // Continuamos incluso si la operación anterior falló
      }
    }

    // Iniciar nueva operación
    final completer = Completer<T>();
    _ongoingOperation = completer.future;
    _currentOperationDescription = description;

    _logger.d('[INFRASTRUCTURE] Iniciando nueva operación "$key"');

    try {
      final result = await operation();
      completer.complete(result);
      _logger.d('[INFRASTRUCTURE] Operación "$key" completada exitosamente');
      return result;
    } catch (e) {
      _logger.e('[INFRASTRUCTURE] Error en operación "$key": $e', error: e);
      completer.completeError(e);
      rethrow;
    } finally {
      if (_currentOperationDescription == description) {
        _ongoingOperation = null;
        _currentOperationDescription = null;
      }
    }
  }
}
