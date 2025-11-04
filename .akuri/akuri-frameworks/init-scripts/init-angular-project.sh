#!/bin/bash
# Script para inicializar un proyecto Angular con configuración Akuri
# Uso: ./init-angular-project.sh <project-name>

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

print_info "🚀 Iniciando creación de proyecto Angular: $PROJECT_NAME"

# Verificar que ng esté disponible
if ! command -v ng &> /dev/null; then
    print_error "Angular CLI no está instalado. Ejecuta: npm install -g @angular/cli"
    exit 1
fi

# Crear proyecto con Angular CLI
print_info "Creando proyecto con Angular CLI..."
ng new "$PROJECT_NAME" --package-manager npm --routing true --style scss --skip-git true

cd "$PROJECT_NAME"

print_success "Proyecto Angular creado exitosamente"

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
description: Manifiesto del proyecto $PROJECT_NAME - Frontend con Angular
status: active
---

# Manifiesto del Proyecto: $PROJECT_NAME

## Información General
- **Nombre del Proyecto:** $PROJECT_NAME
- **Tipo:** Frontend Web Application
- **Framework:** Angular
- **Metodología:** OMA (Organización Modular Akuri)
- **Fecha de Creación:** $(date +%Y-%m-%d)

## Tecnologías Principales
- **Lenguaje:** TypeScript
- **Framework:** Angular
- **Estado Management:** RxJS + Services
- **Styling:** SCSS
- **HTTP Client:** Angular HttpClient
- **Routing:** Angular Router

## Arquitectura OMA
- **Features Globales:** Configuración, autenticación, estilos globales, traducciones
- **Features Compartidos:** Componentes reutilizables, utilidades, servicios comunes
- **Features Standard:** Funcionalidades de negocio con separación lógica vs visual

## Estructura de Carpetas
\`\`\`
src/
├── app/
│   ├── global/              # 🏗️ Features globales
│   │   ├── config/         # Configuración del sistema
│   │   │   ├── environment.ts
│   │   │   └── app.config.ts
│   │   ├── auth/           # Autenticación
│   │   │   ├── auth.service.ts
│   │   │   ├── auth.guard.ts
│   │   │   └── jwt.interceptor.ts
│   │   ├── styles/         # Estilos globales
│   │   │   ├── global.scss
│   │   │   └── theme.scss
│   │   └── i18n/           # Traducciones
│   │       ├── assets/
│   │       └── translation.service.ts
│   ├── shared/             # 🔧 Features compartidos
│   │   ├── utils/         # Utilidades comunes
│   │   │   ├── date.util.ts
│   │   │   └── format.util.ts
│   │   ├── components/    # Componentes compartidos
│   │   │   ├── button.component.ts
│   │   │   └── modal.component.ts
│   │   └── services/      # Servicios compartidos
│   │       └── notification.service.ts
│   └── features/          # 📦 Features standard
│       ├── [feature]/
│       │   ├── services/  # 📊 CAPA LÓGICA
│       │   │   ├── [feature].service.ts
│       │   │   ├── [feature].state.service.ts
│       │   │   └── [feature].actions.ts
│       │   ├── models/    # 📊
│       │   │   ├── [feature].model.ts
│       │   │   └── [feature].dto.ts
│       │   └── presentation/  # 🎨 CAPA VISUAL
│       │       ├── pages/
│       │       │   ├── [feature].list.page.ts
│       │       │   └── [feature].create.page.ts
│       │       ├── components/
│       │       │   ├── [feature].card.component.ts
│       │       │   └── [feature].form.component.ts
│       │       └── layout/
│       │           └── [feature].layout.ts
└── assets/
    └── i18n/              # Archivos de traducción
\`\`\`

## Separación Lógica vs Visual
- **📊 Capa Lógica Primero:** Models, services, state management
- **🎨 Capa Visual Después:** Components, pages, styling con design system

## Configuración Inicial Recomendada
1. Configurar environments (environment.ts, environment.prod.ts)
2. Configurar routing y guards
3. Implementar autenticación básica
4. Configurar internacionalización (i18n)
5. Crear primer feature con separación lógica/visual

## Referencias OMA
- Filosofía: \`akuri-methodology/oma/oma-philosophy.md\`
- Guidelines Angular: \`akuri-methodology/oma/angular/\`
- Arquitectura: \`akuri-manifest/[ARCHITECTURE].project-architecture.md\`
EOF

print_success "Manifiesto del proyecto creado"

# Actualizar angular.json para incluir configuración de assets i18n
print_info "Configurando angular.json para i18n..."
# Nota: En un script real, usaríamos sed o similar para modificar angular.json

# Crear estructura básica OMA
print_info "Creando estructura básica OMA..."
mkdir -p src/app/global/config
mkdir -p src/app/global/auth
mkdir -p src/app/global/styles
mkdir -p src/app/global/i18n
mkdir -p src/app/shared/utils
mkdir -p src/app/shared/components
mkdir -p src/app/shared/services
mkdir -p src/app/features
mkdir -p src/assets/i18n

print_success "Estructura OMA creada"

# Instalar dependencias adicionales comunes
print_info "Instalando dependencias adicionales..."
npm install @angular/material @angular/cdk @angular/platform-browser-dynamic @angular/animations
npm install rxjs lodash moment
npm install --save-dev @types/lodash @types/moment

print_success "Dependencias instaladas"

# Crear archivos de configuración básicos
print_info "Creando archivos de configuración..."

# Environment files
cat > src/environments/environment.ts << EOF
export const environment = {
  production: false,
  apiUrl: 'http://localhost:3000/api',
  appName: '$PROJECT_NAME',
  version: '1.0.0'
};
EOF

cat > src/environments/environment.prod.ts << EOF
export const environment = {
  production: true,
  apiUrl: 'https://api.yourdomain.com/api',
  appName: '$PROJECT_NAME',
  version: '1.0.0'
};
EOF

print_success "Archivos de environment creados"

# Global styles
cat > src/styles.scss << EOF
// Global styles for $PROJECT_NAME

// Import Angular Material theme
@import '@angular/material/theming';

// Include global styles
@import 'app/global/styles/global.scss';
@import 'app/global/styles/theme.scss';

// Custom global styles
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: Roboto, "Helvetica Neue", sans-serif;
}
EOF

# Crear archivos de estilos globales
cat > src/app/global/styles/global.scss << EOF
// Global styles - $PROJECT_NAME

// Reset and base styles
*,
*::before,
*::after {
  box-sizing: border-box;
}

html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}

body {
  font-family: Roboto, "Helvetica Neue", sans-serif;
  background-color: #fafafa;
}

// Utility classes
.text-center { text-align: center; }
.text-left { text-align: left; }
.text-right { text-align: right; }

.d-flex { display: flex; }
.d-block { display: block; }
.d-none { display: none; }

.w-100 { width: 100%; }
.h-100 { height: 100%; }

// Spacing utilities
.m-0 { margin: 0; }
.p-0 { padding: 0; }

.mt-1 { margin-top: 0.25rem; }
.mb-1 { margin-bottom: 0.25rem; }
.mt-2 { margin-top: 0.5rem; }
.mb-2 { margin-bottom: 0.5rem; }
EOF

cat > src/app/global/styles/theme.scss << EOF
// Theme configuration - $PROJECT_NAME

// Define theme colors
\$primary-color: #1976d2;
\$accent-color: #ff4081;
\$warn-color: #f44336;

// Angular Material theme
@include mat-core();

\$primary: mat-palette(\$mat-blue, 700);
\$accent: mat-palette(\$mat-pink, 700);
\$warn: mat-palette(\$mat-red, 700);

\$theme: mat-light-theme(\$primary, \$accent, \$warn);

@include angular-material-theme(\$theme);

// Custom theme variables
:root {
  --primary-color: #{$primary-color};
  --accent-color: #{$accent-color};
  --warn-color: #{$warn-color};

  --text-color: #333;
  --background-color: #fafafa;
  --card-background: #fff;
}
EOF

print_success "Archivos de estilos globales creados"

# Actualizar README
print_info "Actualizando README..."
cat > README.md << EOF
# $PROJECT_NAME

Frontend desarrollado con Angular siguiendo la metodología OMA (Organización Modular Akuri).

## 🚀 Inicio Rápido

\`\`\`bash
# Instalar dependencias
npm install

# Ejecutar en modo desarrollo
npm start

# Construir para producción
npm run build
\`\`\`

## 📁 Estructura del Proyecto

Este proyecto sigue la metodología OMA con la siguiente estructura:

- \`src/app/global/\` - Features globales (config, auth, styles, i18n)
- \`src/app/shared/\` - Features compartidos (utils, common components)
- \`src/app/features/\` - Features de negocio con separación lógica vs visual

### Separación Lógica vs Visual
- **📊 Capa Lógica:** \`features/[name]/services/\` y \`features/[name]/models/\`
- **🎨 Capa Visual:** \`features/[name]/presentation/\`

## 🛠️ Tecnologías

- **Angular** - Framework web
- **TypeScript** - Lenguaje de programación
- **RxJS** - Programación reactiva
- **SCSS** - Preprocesador CSS
- **Angular Material** - Componentes UI

## 📚 Documentación OMA

- [Filosofía OMA](.akuri/akuri-methodology/oma/oma-philosophy.md)
- [Guidelines Angular](.akuri/akuri-methodology/oma/angular/)
- [Arquitectura del Proyecto](.akuri/akuri-manifest/[ARCHITECTURE].project-architecture.md)

## 🔧 Scripts Disponibles

- \`npm start\` - Servidor desarrollo (http://localhost:4200)
- \`npm run build\` - Build producción
- \`npm test\` - Ejecutar tests unitarios
- \`npm run lint\` - Ejecutar linter
EOF

print_success "README actualizado"

print_success "🎉 Proyecto $PROJECT_NAME inicializado exitosamente con Akuri!"
print_info "Próximos pasos:"
echo "  1. Configurar variables de entorno (src/environments/)"
echo "  2. Revisar documentación OMA en .akuri/"
echo "  3. Ejecutar 'npm start' para desarrollo"
echo "  4. Comenzar con BUILD-LOGIC para el primer feature"