# Plan de Refactorización: Sistema de Logging con Logger Package

## 📋 Resumen Ejecutivo

Este documento detalla el plan de refactorización para unificar el logging distribuido en SIGApp usando el paquete `logger` de pub.dev, preparando el proyecto para Firebase Crashlytics de manera simple y eficiente.

## 🔍 Situación Actual

### Análisis del Código Existente

**Total de archivos con logging:** 25+ archivos identificados
**Tipos de logging actuales:**

- `developer.log()` con parámetros `name`, `error`, `stackTrace` (19 archivos)
- `print()` básico con/sin `kDebugMode` (12 archivos adicionales)
- Logging de requests/responses HTTP
- Logging de autenticación y sesiones
- Logging de base de datos
- Logging de errores de negocio
- Logging de UI/debugging en desarrollo
- Debug logging en charts y componentes

### Patrones Identificados

#### **Categoría 1: HTTP Logging (Developer.log)**

- `http_client_builder.dart`: Logging detallado de requests/responses (8 ocurrencias)
- `api_logger.dart`: Logging específico de API Gateway (6 ocurrencias)
- `token_refresher_manager.dart`: Logging de refresh de tokens (8 ocurrencias)

#### **Categoría 2: Authentication Logging (Developer.log)**

- `authentication_manager.dart`: Logging extensivo del ciclo de vida de sesión (15 ocurrencias)
- `sign_in_usecase.dart`: Logging de procesos de autenticación (4 ocurrencias)
- `session_lifecycle_service.dart`: Interceptores y validaciones (4 ocurrencias)
- `api_gateway_auth_service.dart`: Autenticación con Supabase (3 ocurrencias)

#### **Categoría 3: Database Logging (Developer.log)**

- `sqlite_client_manager.dart`: Logging de operaciones de BD (1 ocurrencia)
- `grade_tracking_repository.dart`: Operaciones CRUD (7 ocurrencias)

#### **Categoría 4: Print-based Logging (Print + kDebugMode)**

- `student_cubit.dart`: Error handling con print (2 ocurrencias)
- `home_page_cubit.dart`: Error logging (2 ocurrencias)
- `course_detail_cubit.dart`: Error handling (2 ocurrencias)
- `grade_tracker_section_cubit.dart`: Debug y error tracking (2 ocurrencias)
- `scheduled_courses_cubit.dart`: Error logging (2 ocurrencias)
- `enrolled_courses_page_cubit.dart`: Error tracking (2 ocurrencias)
- `user_avatar_button_cubit.dart`: Error handling (4 ocurrencias)
- `schedule_share_button.dart`: Success/error/share status (4 ocurrencias)
- `weekly_schedule.dart`: Debug para horarios (1 ocurrencia)
- `grades_per_course_category_chart.dart`: Debug de datos (2 ocurrencias)

#### **Categoría 5: Specialized Logging**

- `export_to_calendar_cubit.dart`: Extenso logging de calendario (15+ ocurrencias)
- `mail_utils.dart`: Error logging para email (1 ocurrencia)

#### **Categoría 6: Error Handling**

- Combinación de `developer.log` con try-catch
- Logging de stack traces
- Diferentes niveles implícitos de logging
- **SessionException** family: Manejo estructurado de errores de sesión

## 🎯 Objetivos de la Refactorización

### Problema Real: "No Estar a Ciegas en Producción"

**Escenario:** Estás en la playa, te llega mensaje: _"La app no funciona"_

**Solución:** Logger Package → Firebase Crashlytics = Visibilidad total sin laptop

### Objetivos Funcionales

1. **Logger como Dependency (Clean Architecture)**

   - Inyectar `Logger` en use cases, repositories, cubits
   - Cero acoplamiento: cada capa logea sin conocer el destino

2. **LogOutput → Firebase Crashlytics**

   - Desarrollo: logs a console con `PrettyPrinter`
   - Producción: logs a Firebase automáticamente
   - Errores críticos → notificaciones push

3. **Visibilidad por Capas**

   - `[DOMAIN] SignInUseCase failed` → contexto de negocio
   - `[INFRASTRUCTURE] HTTP 500 error` → contexto técnico
   - `[UI] Widget rendering error` → contexto de presentación

4. **Zero Configuration per Environment**
   - `kDebugMode`: logs bonitos en console
   - `kReleaseMode`: solo errores/warnings a Firebase

### Resultado Concreto

**En Firebase Console verás:**

- ✅ Error exacto + stack trace + línea de código
- ✅ Dispositivo, OS, versión de app afectada
- ✅ Frecuencia: ¿1 usuario o 1000?
- ✅ Logs previos: qué hizo el usuario antes del crash
- ✅ **Contexto por capa:** Domain/Infrastructure/UI

**Decisión desde la playa:** _"Es el bug del token, afecta a 3 usuarios, no es crítico, lo arreglo el lunes"_

## 🏗️ Arquitectura Simplificada con Logger Package

### Estructura Minimalista

```text
core/infrastructure/logging/
├── app_logger.dart              # Wrapper configurado del Logger package
└── outputs/
    └── firebase_log_output.dart # LogOutput personalizado para Firebase
```

### Configuración Funcional

```dart
// lib/core/infrastructure/logging/app_logger.dart
@singleton
Logger appLogger() {
  return Logger(
    filter: kReleaseMode ? ProductionFilter() : DevelopmentFilter(),
    printer: kReleaseMode ? SimplePrinter() : PrettyPrinter(colors: true),
    output: MultiOutput([
      if (kDebugMode) ConsoleOutput(),
      if (kReleaseMode) FirebaseLogOutput(),
    ]),
  );
}

// lib/core/infrastructure/logging/outputs/firebase_log_output.dart
class FirebaseLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      if (event.level.index >= Level.error.index) {
        FirebaseCrashlytics.instance.recordError(
          line, null, fatal: event.level == Level.fatal,
        );
      }
      FirebaseCrashlytics.instance.log(line);
    }
  }
}
```

### Uso por Capas (Clean Architecture)

```dart
// DOMAIN - Use Case
class SignInUseCase {
  final AuthRepository _repository;
  final Logger _logger;

  Future<Either<Failure, User>> execute(Credentials creds) async {
    _logger.i('[DOMAIN] SignIn started');
    try {
      final result = await _repository.signIn(creds);
      _logger.i('[DOMAIN] SignIn successful');
      return result;
    } catch (e, stack) {
      _logger.e('[DOMAIN] SignIn failed', error: e, stackTrace: stack);
      return Left(AuthFailure());
    }
  }
}

// INFRASTRUCTURE - Repository
class AuthRepositoryImpl implements AuthRepository {
  final SigaClient _client;
  final Logger _logger;

  Future<User> signIn(Credentials creds) async {
    _logger.d('[INFRASTRUCTURE] HTTP request to /auth/login');
    try {
      final response = await _client.post('/auth/login', data: creds.toJson());
      _logger.d('[INFRASTRUCTURE] HTTP 200 OK');
      return User.fromJson(response.data);
    } on DioException catch (e, stack) {
      _logger.e('[INFRASTRUCTURE] HTTP error', error: e, stackTrace: stack);
      throw NetworkException();
    }
  }
}

// PRESENTATION - Cubit
class LoginCubit extends Cubit<LoginState> {
  final SignInUseCase _signInUseCase;
  final Logger _logger;

  Future<void> signIn(String username, String password) async {
    _logger.d('[UI] Login button pressed');
    emit(LoginLoading());

    final result = await _signInUseCase.execute(Credentials(username, password));
    result.fold(
      (failure) {
        _logger.w('[UI] Login failed, showing error');
        emit(LoginFailure(failure.message));
      },
      (user) {
        _logger.i('[UI] Login successful, navigating to home');
        emit(LoginSuccess(user));
      },
    );
  }
}
```

## 📅 Plan de Implementación Simplificado

### Fase 1: Setup del Logger Package

#### Tareas:

1. **Agregar dependencia:**

   ```bash
   flutter pub add logger
   ```

2. **Crear configuración básica:**

   - Crear `app_logger.dart` con configuración por entorno
   - Registrar en dependency injection (get_it)
   - Configurar LogFilter para desarrollo vs producción

3. **Crear LogOutput para Firebase (preparación):**
   - Implementar `FirebaseLogOutput` (inicialmente vacío)
   - Configurar MultiOutput para console + firebase

#### Archivos a crear:

```text
lib/core/infrastructure/logging/
├── app_logger.dart
└── outputs/
    └── firebase_log_output.dart
```

### Fase 2: Migración por Prioridad

#### 2.1 Archivos Críticos

- `authentication_manager.dart` (15 ocurrencias)
- `http_client_builder.dart` (8 ocurrencias)
- `session_lifecycle_service.dart` (4 ocurrencias)
- `token_refresher_manager.dart` (8 ocurrencias)

#### 2.2 Archivos de Impacto Medio

- `api_logger.dart` (6 ocurrencias)
- `grade_tracking_repository.dart` (7 ocurrencias)
- `sign_in_usecase.dart` (4 ocurrencias)
- `api_gateway_auth_service.dart` (3 ocurrencias)

#### 2.3 UI/Cubits con Print

- `export_to_calendar_cubit.dart` (15+ ocurrencias)
- 8 archivos de cubits restantes (2 ocurrencias c/u)

**Migración Simple - Patrón Único**

```dart
// ANTES (developer.log disperso)
import 'dart:developer' as developer;
developer.log('Sign in started', name: 'Auth', error: e, stackTrace: stack);

// DESPUÉS (Logger inyectado)
class SignInUseCase {
  final Logger _logger; // ← Inyectado por get_it

  _logger.i('[DOMAIN] Sign in started');
  _logger.e('[DOMAIN] Sign in failed', error: e, stackTrace: stack);
}
```

**Resultado en Firebase Console**

- 🎯 **Error:** `[DOMAIN] Sign in failed`
- 🎯 **Stack:** `lib/auth/application/usecases/sign_in_usecase.dart:42`
- 🎯 **Device:** `iPhone 12, iOS 15.0, SIGApp v2.0.5`
- 🎯 **Context:** Logs previos del usuario
- 🎯 **Frequency:** 3 usuarios afectados en las últimas 2 horas

### Fase 3: Firebase Integration

#### 3.1 Agregar Firebase Crashlytics

- `flutter pub add firebase_crashlytics`
- Implementar `FirebaseLogOutput.output()`
- Mapear niveles Logger → Crashlytics

#### 3.2 Testing

- Verificar logs en desarrollo (console)
- Verificar logs en Firebase Console
- Performance testing

## 📊 Archivos Afectados - Resumen Ejecutivo

### Total: 25+ archivos con 80+ ocurrencias de logging

#### Categoría A: Críticos (developer.log)

| Archivo                          | Ocurrencias |
| -------------------------------- | ----------- |
| `authentication_manager.dart`    | 15          |
| `http_client_builder.dart`       | 8           |
| `token_refresher_manager.dart`   | 8           |
| `grade_tracking_repository.dart` | 7           |
| `api_logger.dart`                | 6           |
| `session_lifecycle_service.dart` | 4           |

#### Categoría B: UI/Cubits (print + kDebugMode)

| Archivo                         | Ocurrencias |
| ------------------------------- | ----------- |
| `export_to_calendar_cubit.dart` | 15+         |
| 8 archivos de cubits            | 2-4 c/u     |

### Total: 25+ archivos con 80+ ocurrencias de logging

## 🎯 Métricas de Éxito

### Técnicas

- [ ] 0 ocurrencias de `developer.log` en producción
- [ ] 0 ocurrencias de `print()` sin control
- [ ] Logger package integrado en 100% de casos
- [ ] Firebase Crashlytics recibiendo logs de errores

### Operacionales

- [ ] Logs bonitos en desarrollo (PrettyPrinter)
- [ ] Logs automáticos en Firebase para producción
- [ ] Zero performance impact (ProductionFilter)
- [ ] Clean Architecture mantenida (Logger como dependency)

## 🚀 Quick Start

### Setup inmediato

1. **Agregar dependency:**

   ```bash
   flutter pub add logger
   ```

2. **Crear configuración mínima:**

   ```dart
   // lib/core/infrastructure/logging/app_logger.dart
   @singleton
   Logger appLogger() => Logger();
   ```

3. **Migrar 1 archivo crítico** (ej: `authentication_manager.dart`)

**Resultado:** Logging unificado funcionando, resto es iterativo.

---

## 📋 Resultado Final - Tranquilidad en Producción

**Escenario Real:** Mensaje a las 2 PM _"La app crashea en login"_

**Tu respuesta desde la playa:**

_"Vi en Firebase Console:_

- _Error en `SignInUseCase.dart` línea 47_
- _Afecta solo a 3 usuarios con Android 12_
- _Es el bug del token expirado que ya tengo identificado_
- _No es crítico, hotfix programado para mañana"_

**Sin logging estructurado:** _"No tengo idea, necesito la laptop, cancelo el día en la playa"_

**Con logger + Firebase:** _"Contexto completo, decisión informada, día salvado"_

### Beneficios Medibles

✅ **Time to Resolution:** Diagnóstico inmediato vs horas de investigación  
✅ **Context Completeness:** Stack + device + frequency vs "algo falló"  
✅ **Clean Architecture:** Zero acoplamiento, Logger como dependency limpia  
✅ **Zero Maintenance:** Logger package battle-tested, Firebase managed service  
✅ **Incremental Migration:** Un archivo a la vez, sin riesgos

---

_Estado: Simplificado para usar Logger Package_
