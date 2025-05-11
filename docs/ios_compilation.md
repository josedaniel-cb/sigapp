# Plan Detallado para Compilar SIGApp en iOS

Este documento contiene instrucciones paso a paso para la compilación de SIGApp en iOS partiendo de la versión Android existente.

## Preparativos

> **Requisitos**: MacOS, Xcode instalado y actualizado, y una cuenta de desarrollador de Apple.

## 1. Activar soporte para iOS en Flutter Launcher Icons

**Archivo**: `flutter_launcher_icons.yaml`

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true # Añadir esta línea
  image_path: "assets/launcher_icon.png"
  # ...resto del código existente...
```

**Ejecutar después**:

```bash
flutter pub run flutter_launcher_icons
```

## 2. Configurar Info.plist

**Archivo**: `ios/Runner/Info.plist`

Añadir las siguientes configuraciones:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>https</string>
  <string>http</string>
  <string>mailto</string>
</array>

<!-- Para url_launcher -->
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>

<!-- Para share_plus -->
<key>NSPhotoLibraryUsageDescription</key>
<string>Necesitamos acceso para guardar y compartir capturas de pantalla</string>

<!-- Para flutter_secure_storage -->
<key>NSFaceIDUsageDescription</key>
<string>Para autenticación segura</string>

<!-- Para path_provider y open_file -->
<key>LSSupportsOpeningDocumentsInPlace</key>
<true/>
<key>UIFileSharingEnabled</key>
<true/>
```

## 3. Configurar Bundle Identifier

**Archivo**: `ios/Runner/Info.plist`

```xml
<key>CFBundleIdentifier</key>
<string>com.josedanielcb.sigapp</string>
```

**Archivo**: `ios/Runner.xcodeproj/project.pbxproj`

```
PRODUCT_BUNDLE_IDENTIFIER = com.josedanielcb.sigapp;
```

## 4. Configurar Podfile

**Archivo**: `ios/Podfile`

```ruby
# Configurar plataforma mínima (basado en tus dependencias)
platform :ios, '12.0'

# Actualizar post_install para compatibilidad
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      # Arreglo para M1/M2 Macs
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
```

## 5. Secuencia de comandos para compilación

```bash
# Limpiar y actualizar dependencias
flutter clean
flutter pub get

# Generar archivos de iOS
cd ios
pod install
cd ..

# Abrir Xcode para firmar la app
open ios/Runner.xcworkspace
```

## 6. Configuración en Xcode

1. **Seleccionar proyecto**:

   - Seleccionar "Runner" en el navegador de Xcode
   - Seleccionar "Runner" bajo TARGETS

2. **Configurar Signing & Capabilities**:

   - Iniciar sesión con Apple ID
   - Seleccionar Equipo de desarrollo
   - Bundle Identifier: `com.josedanielcb.sigapp`
   - Activar "Automatically manage signing"

3. **Configurar versión**:
   - En "Build Settings", buscar "Version"
   - "Marketing Version": 2.0.1
   - "Current Project Version": 9

## 7. Compatibilidad con paquetes específicos

### Para device_calendar (si se activa)

**Archivo**: `ios/Runner/Info.plist`

```xml
<key>NSCalendarsUsageDescription</key>
<string>Esta aplicación necesita acceso a tu calendario para agregar eventos</string>
```

## 8. Compilación

```bash
# Build para simulador
flutter build ios --simulator

# Build para dispositivo físico (después de firmar)
flutter build ios
```

## 9. Pruebas en simulador

```bash
flutter run -d "iPhone Simulator"
```

## 10. Preparación para TestFlight (opcional)

En Xcode:

1. Product > Archive
2. Window > Organizer > Seleccionar archivo > Distribute App > App Store Connect

## Solución de problemas comunes

1. **Errores de pod install**:

   ```bash
   cd ios
   pod repo update
   pod install --repo-update
   ```

2. **Errores de compatibilidad de versiones**:
   Verificar que todas las dependencias de Flutter sean compatibles con iOS 12.0 o superior.

3. **Errores de firma**:
   Asegurarse de tener una cuenta de desarrollador de Apple válida y configurar correctamente el certificado.
