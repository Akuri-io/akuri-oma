#!/bin/bash
# Script para inicializar un proyecto Flutter con configuración Akuri
# Uso: ./init-flutter-project.sh <project-name>

set -e  # Salir si hay error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes coloreados
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Verificar argumentos
if [ $# -eq 0 ]; then
    print_error "Uso: $0 <project-name>"
    exit 1
fi

PROJECT_NAME=$1

print_info "🚀 Iniciando creación de proyecto Flutter: $PROJECT_NAME"

# Verificar que flutter esté disponible
if ! command -v flutter &> /dev/null; then
    print_error "Flutter no está instalado o no está en PATH."
    print_info "Instala Flutter desde: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Verificar que flutter doctor esté ok
print_info "Verificando instalación de Flutter..."
if ! flutter doctor --suppress-analytics | grep -q "No issues found"; then
    print_warning "Hay problemas con la instalación de Flutter. Ejecuta 'flutter doctor' para más detalles."
fi

# Crear proyecto con Flutter CLI
print_info "Creando proyecto con Flutter CLI..."
flutter create "$PROJECT_NAME" --suppress-analytics

cd "$PROJECT_NAME"

print_success "Proyecto Flutter creado exitosamente"

# Crear estructura .akuri
print_info "Creando estructura .akuri..."
mkdir -p .akuri/akuri-manifest
mkdir -p .akuri/akuri-specs
mkdir -p .akuri/akuri-work

# Crear manifiesto del proyecto
print_info "Creando manifiesto del proyecto..."
cat > .akuri/akuri-manifest/project.manifest.md << EOF
---
trigger: always_on
description: Manifiesto del proyecto $PROJECT_NAME - Mobile App con Flutter
status: active
---

# Manifiesto del Proyecto: $PROJECT_NAME

## Información General
- **Nombre del Proyecto:** $PROJECT_NAME
- **Tipo:** Mobile Application
- **Framework:** Flutter
- **Metodología:** OMA (Organización Modular Akuri)
- **Fecha de Creación:** $(date +%Y-%m-%d)

## Tecnologías Principales
- **Lenguaje:** Dart
- **Framework:** Flutter
- **Estado Management:** Riverpod
- **Networking:** Dio HTTP Client
- **Almacenamiento Local:** SharedPreferences + SQLite
- **Inyección de Dependencias:** Riverpod

## Arquitectura OMA
- **Features Globales:** Configuración, autenticación, almacenamiento, tema
- **Features Compartidos:** Widgets reutilizables, utilidades, servicios comunes
- **Features Standard:** Funcionalidades de negocio con separación lógica vs visual

## Estructura de Carpetas
\`\`\`
lib/
├── global/                # 🏗️ Features globales
│   ├── config/           # Configuración del sistema
│   │   ├── app.config.dart
│   │   └── environment.dart
│   ├── auth/             # Autenticación
│   │   ├── auth.provider.dart
│   │   ├── auth.service.dart
│   │   └── auth.guard.dart
│   ├── storage/          # Persistencia local
│   │   ├── storage.service.dart
│   │   └── shared.preferences.dart
│   └── theme/            # Tema global
│       ├── app.theme.dart
│       └── theme.provider.dart
├── shared/               # 🔧 Features compartidos
│   ├── utils/           # Utilidades comunes
│   │   ├── date.util.dart
│   │   └── format.util.dart
│   ├── widgets/         # Widgets compartidos
│   │   ├── custom.button.widget.dart
│   │   └── loading.widget.dart
│   └── services/        # Servicios compartidos
│       └── notification.service.dart
└── features/            # 📦 Features standard
    ├── [feature]/
    │   ├── models/     # 📊 CAPA LÓGICA
    │   │   ├── [feature].model.dart
    │   │   └── [feature].dto.dart
    │   ├── providers/  # 📊
    │   │   ├── [feature].provider.dart
    │   │   └── [feature].state.provider.dart
    │   ├── services/   # 📊
    │   │   └── [feature].api.service.dart
    │   ├── screens/    # 🎨 CAPA VISUAL
    │   │   ├── [feature].list.screen.dart
    │   │   └── [feature].create.screen.dart
    │   └── widgets/    # 🎨
    │       ├── [feature].card.widget.dart
    │       └── [feature].form.widget.dart
\`\`\`

## Separación Lógica vs Visual
- **📊 Capa Lógica Primero:** Models, providers, services, state management
- **🎨 Capa Visual Después:** Screens, widgets, UI con separación de responsabilidades

## Configuración Inicial Recomendada
1. Configurar variables de entorno
2. Configurar Riverpod como provider global
3. Implementar autenticación básica
4. Configurar tema y navegación
5. Crear primer feature con separación lógica/visual

## Referencias OMA
- Filosofía: \`akuri-methodology/oma/oma-philosophy.md\`
- Guidelines Flutter: \`akuri-methodology/oma/flutter/\`
- Arquitectura: \`akuri-manifest/[ARCHITECTURE].project-architecture.md\`
EOF

print_success "Manifiesto del proyecto creado"

# Actualizar pubspec.yaml con dependencias comunes
print_info "Actualizando pubspec.yaml con dependencias OMA..."
cat >> pubspec.yaml << EOF

# OMA Dependencies
dependencies:
  flutter_riverpod: ^2.3.6
  dio: ^5.1.2
  shared_preferences: ^2.1.2
  sqflite: ^2.2.8
  path_provider: ^2.0.15
  freezed_annotation: ^2.2.0
  json_annotation: ^4.8.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.6
  freezed: ^2.3.5
  json_serializable: ^6.6.2
  flutter_lints: ^2.0.0

# The following section is specific to Flutter packages.
flutter:
EOF

print_success "Dependencias agregadas a pubspec.yaml"

# Crear estructura básica OMA
print_info "Creando estructura básica OMA..."
mkdir -p lib/global/config
mkdir -p lib/global/auth
mkdir -p lib/global/storage
mkdir -p lib/global/theme
mkdir -p lib/shared/utils
mkdir -p lib/shared/widgets
mkdir -p lib/shared/services
mkdir -p lib/features

print_success "Estructura OMA creada"

# Crear archivos de configuración básicos
print_info "Creando archivos de configuración..."

# App config
cat > lib/global/config/app.config.dart << EOF
class AppConfig {
  static const String appName = '$PROJECT_NAME';
  static const String version = '1.0.0';
  static const bool isProduction = false;

  // API Configuration
  static const String baseUrl = 'https://api.yourdomain.com';
  static const Duration timeout = Duration(seconds: 30);

  // Local Storage
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';

  // Feature flags
  static const bool enableAnalytics = false;
  static const bool enableCrashReporting = true;
}
EOF

# Environment
cat > lib/global/config/environment.dart << EOF
enum Environment { development, staging, production }

class AppEnvironment {
  static Environment current = Environment.development;

  static String get baseUrl {
    switch (current) {
      case Environment.development:
        return 'http://localhost:3000/api';
      case Environment.staging:
        return 'https://staging-api.yourdomain.com/api';
      case Environment.production:
        return 'https://api.yourdomain.com/api';
    }
  }

  static bool get isDevelopment => current == Environment.development;
  static bool get isProduction => current == Environment.production;
}
EOF

print_success "Archivos de configuración creados"

# Crear providers globales básicos
print_info "Creando providers globales..."

# Dio provider
cat > lib/global/config/dio.provider.dart << EOF
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.config.dart';
import 'environment.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: AppEnvironment.baseUrl,
    connectTimeout: AppConfig.timeout,
    receiveTimeout: AppConfig.timeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add interceptors
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));

  return dio;
});
EOF

# Theme provider
cat > lib/global/theme/theme.provider.dart << EOF
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void setLightMode() => state = ThemeMode.light;
  void setDarkMode() => state = ThemeMode.dark;
  void setSystemMode() => state = ThemeMode.system;
}

final appThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
  );
});

final darkAppThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  );
});
EOF

print_success "Providers globales creados"

# Crear utilidades básicas
print_info "Creando utilidades básicas..."

cat > lib/shared/utils/date.util.dart << EOF
import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String formatDateTime(DateTime date, {String format = 'dd/MM/yyyy HH:mm'}) {
    return DateFormat(format).format(date);
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} años';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} meses';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} días';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutos';
    } else {
      return 'Ahora';
    }
  }
}
EOF

cat > lib/shared/utils/format.util.dart << EOF
class FormatUtil {
  static String currency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  static String percentage(double value) {
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
EOF

print_success "Utilidades básicas creadas"

# Actualizar main.dart con configuración OMA
print_info "Configurando main.dart con Riverpod..."

cat > lib/main.dart << EOF
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'global/config/app.config.dart';
import 'global/theme/theme.provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final lightTheme = ref.watch(appThemeProvider);
    final darkTheme = ref.watch(darkAppThemeProvider);

    return MaterialApp(
      title: AppConfig.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
      ),
      body: const Center(
        child: Text('Welcome to $PROJECT_NAME'),
      ),
    );
  }
}
EOF

print_success "main.dart configurado"

# Actualizar README
print_info "Actualizando README..."
cat > README.md << EOF
# $PROJECT_NAME

Mobile app desarrollada con Flutter siguiendo la metodología OMA (Organización Modular Akuri).

## 🚀 Inicio Rápido

\`\`\`bash
# Instalar dependencias
flutter pub get

# Ejecutar en modo desarrollo
flutter run

# Construir APK
flutter build apk
\`\`\`

## 📁 Estructura del Proyecto

Este proyecto sigue la metodología OMA con la siguiente estructura:

- \`lib/global/\` - Features globales (config, auth, storage, theme)
- \`lib/shared/\` - Features compartidos (utils, common widgets)
- \`lib/features/\` - Features de negocio con separación lógica vs visual

### Separación Lógica vs Visual
- **📊 Capa Lógica:** \`features/[name]/models/\`, \`features/[name]/providers/\`, \`features/[name]/services/\`
- **🎨 Capa Visual:** \`features/[name]/screens/\`, \`features/[name]/widgets/\`

## 🛠️ Tecnologías

- **Flutter** - Framework mobile
- **Dart** - Lenguaje de programación
- **Riverpod** - Estado management
- **Dio** - HTTP client
- **Freezed** - Generación de modelos
- **SharedPreferences** - Almacenamiento local

## 📚 Documentación OMA

- [Filosofía OMA](.akuri/akuri-methodology/oma/oma-philosophy.md)
- [Guidelines Flutter](.akuri/akuri-methodology/oma/flutter/)
- [Arquitectura del Proyecto](.akuri/akuri-manifest/[ARCHITECTURE].project-architecture.md)

## 🔧 Scripts Disponibles

- \`flutter run\` - Ejecutar en dispositivo/emulador
- \`flutter build apk\` - Construir APK Android
- \`flutter build ios\` - Construir iOS (requiere macOS)
- \`flutter test\` - Ejecutar tests
- \`flutter analyze\` - Análisis de código
EOF

print_success "README actualizado"

# Ejecutar flutter pub get
print_info "Instalando dependencias..."
flutter pub get --suppress-analytics

print_success "Dependencias instaladas"

print_success "🎉 Proyecto $PROJECT_NAME inicializado exitosamente con Akuri!"
print_info "Próximos pasos:"
echo "  1. Configurar variables de entorno (lib/global/config/)"
echo "  2. Revisar documentación OMA en .akuri/"
echo "  3. Ejecutar 'flutter run' para desarrollo"
echo "  4. Comenzar con BUILD-LOGIC para el primer feature"