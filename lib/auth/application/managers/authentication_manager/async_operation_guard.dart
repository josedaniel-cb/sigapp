import 'dart:async';
import 'dart:developer' as developer;

/// Garantiza que operaciones asíncronas críticas no se ejecuten simultáneamente
/// y permite que múltiples solicitantes compartan el resultado de una sola ejecución
class AsyncOperationGuard {
  /// Future que representa la operación en curso, si existe
  Future<dynamic>? _ongoingOperation;

  /// Identificador para depuración de la operación en curso
  String? _currentOperationDescription;

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
      developer.log(
        'Operación "$key" ya en progreso, esperando resultado compartido...',
        name: 'OperationSynchronizer',
      );

      try {
        // Esperar y devolver el resultado de la operación en curso
        // El cast es seguro porque verificamos que el tipo de operación es el mismo
        final result = await _ongoingOperation as T;
        developer.log(
          'Operación en progreso "$key" completada, devolviendo resultado compartido',
          name: 'OperationSynchronizer',
        );
        return result;
      } catch (e) {
        developer.log(
          'Operación en progreso "$key" falló, propagando error compartido: $e',
          name: 'OperationSynchronizer',
          error: e,
        );
        rethrow;
      }
    }

    // Si hay otra operación diferente en curso, esperar a que termine
    if (_ongoingOperation != null) {
      developer.log(
        'Operación diferente "$_currentOperationDescription" en progreso, esperando antes de iniciar "$key"...',
        name: 'OperationSynchronizer',
      );
      try {
        await _ongoingOperation;
        developer.log(
          'Operación previa completada, ahora ejecutando "$key"',
          name: 'OperationSynchronizer',
        );
      } catch (e) {
        developer.log(
          'Operación previa falló, ejecutando "$key" de todos modos',
          name: 'OperationSynchronizer',
        );
        // Continuamos incluso si la operación anterior falló
      }
    }

    // Iniciar nueva operación
    final completer = Completer<T>();
    _ongoingOperation = completer.future;
    _currentOperationDescription = description;

    developer.log(
      'Iniciando nueva operación "$key"',
      name: 'OperationSynchronizer',
    );

    try {
      final result = await operation();
      completer.complete(result);
      developer.log(
        'Operación "$key" completada exitosamente',
        name: 'OperationSynchronizer',
      );
      return result;
    } catch (e) {
      developer.log(
        'Error en operación "$key": $e',
        name: 'OperationSynchronizer',
        error: e,
      );
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
