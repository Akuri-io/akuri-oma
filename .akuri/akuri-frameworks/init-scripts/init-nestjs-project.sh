#!/bin/bash
# Script para inicializar un proyecto NestJS con configuración Akuri
# Uso: ./init-nestjs-project.sh <project-name>

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

print_info "🚀 Iniciando creación de proyecto NestJS: $PROJECT_NAME"

# Verificar que npx esté disponible
if ! command -v npx &> /dev/null; then
    print_error "npx no está instalado. Instala Node.js primero."
    exit 1
fi

# Verificar que @nestjs/cli esté disponible
if ! npx @nestjs/cli --version &> /dev/null; then
    print_warning "@nestjs/cli no está disponible globalmente. Se instalará temporalmente."
fi

# Crear proyecto con NestJS CLI
print_info "Creando proyecto con NestJS CLI..."
npx @nestjs/cli new "$PROJECT_NAME" --package-manager npm --skip-git

cd "$PROJECT_NAME"

print_success "Proyecto NestJS creado exitosamente"

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
description: Manifiesto del proyecto $PROJECT_NAME - Backend API con NestJS
status: active
---

# Manifiesto del Proyecto: $PROJECT_NAME

## Información General
- **Nombre del Proyecto:** $PROJECT_NAME
- **Tipo:** Backend API
- **Framework:** NestJS
- **Metodología:** OMA (Organización Modular Akuri)
- **Fecha de Creación:** $(date +%Y-%m-%d)

## Tecnologías Principales
- **Lenguaje:** TypeScript
- **Framework:** NestJS
- **Base de Datos:** PostgreSQL (configurar según necesidades)
- **ORM:** TypeORM
- **Autenticación:** JWT
- **Documentación:** Swagger/OpenAPI

## Arquitectura OMA
- **Features Globales:** Configuración, autenticación, base de datos
- **Features Compartidos:** Utilidades, validadores, servicios comunes
- **Features Standard:** Módulos de negocio específicos

## Estructura de Carpetas
\`\`\`
src/
├── global/              # 🏗️ Features globales
│   ├── config/         # Configuración del sistema
│   ├── auth/           # Autenticación
│   └── database/       # Conexión BD
├── shared/             # 🔧 Features compartidos
│   ├── utils/         # Utilidades comunes
│   └── services/      # Servicios compartidos
└── features/          # 📦 Features standard
    └── [feature-name]/
        ├── [feature].module.ts
        ├── controllers/
        ├── services/
        ├── models/
        └── dto/
\`\`\`

## Configuración Inicial Recomendada
1. Configurar variables de entorno (.env)
2. Configurar conexión a base de datos
3. Implementar autenticación básica
4. Crear primer módulo de ejemplo
5. Configurar testing

## Referencias OMA
- Filosofía: \`akuri-methodology/oma/oma-philosophy.md\`
- Guidelines NestJS: \`akuri-methodology/oma/nestjs/\`
- Arquitectura: \`akuri-manifest/[ARCHITECTURE].project-architecture.md\`
EOF

print_success "Manifiesto del proyecto creado"

# Crear archivo README básico
print_info "Creando README del proyecto..."
cat > README.md << EOF
# $PROJECT_NAME

Backend API desarrollado con NestJS siguiendo la metodología OMA (Organización Modular Akuri).

## 🚀 Inicio Rápido

\`\`\`bash
# Instalar dependencias
npm install

# Configurar variables de entorno
cp .env.example .env

# Ejecutar en modo desarrollo
npm run start:dev
\`\`\`

## 📁 Estructura del Proyecto

Este proyecto sigue la metodología OMA con la siguiente estructura:

- \`src/global/\` - Features globales (config, auth, database)
- \`src/shared/\` - Features compartidos (utils, common services)
- \`src/features/\` - Features de negocio específicos

## 🛠️ Tecnologías

- **NestJS** - Framework Node.js
- **TypeScript** - Lenguaje de programación
- **TypeORM** - ORM para base de datos
- **JWT** - Autenticación
- **Swagger** - Documentación API

## 📚 Documentación OMA

- [Filosofía OMA](.akuri/akuri-methodology/oma/oma-philosophy.md)
- [Guidelines NestJS](.akuri/akuri-methodology/oma/nestjs/)
- [Arquitectura del Proyecto](.akuri/akuri-manifest/[ARCHITECTURE].project-architecture.md)

## 🔧 Scripts Disponibles

- \`npm run start\` - Producción
- \`npm run start:dev\` - Desarrollo
- \`npm run test\` - Ejecutar tests
- \`npm run test:cov\` - Tests con cobertura
EOF

print_success "README del proyecto creado"

# Crear archivo .env.example
print_info "Creando archivo .env.example..."
cat > .env.example << EOF
# Base de Datos
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=your_username
DB_PASSWORD=your_password
DB_DATABASE=your_database

# JWT
JWT_SECRET=your_jwt_secret_key_here
JWT_EXPIRES_IN=1h

# Aplicación
NODE_ENV=development
PORT=3000

# Otros servicios (configurar según necesidades)
# REDIS_HOST=localhost
# REDIS_PORT=6379
EOF

print_success "Archivo .env.example creado"

# Instalar dependencias adicionales comunes
print_info "Instalando dependencias adicionales..."
npm install @nestjs/config @nestjs/jwt @nestjs/passport passport passport-jwt @nestjs/typeorm typeorm pg class-validator class-transformer
npm install --save-dev @types/passport-jwt

print_success "Dependencias instaladas"

# Crear estructura básica OMA
print_info "Creando estructura básica OMA..."
mkdir -p src/global/config
mkdir -p src/global/auth
mkdir -p src/global/database
mkdir -p src/shared/utils
mkdir -p src/shared/services
mkdir -p src/features

print_success "Estructura OMA creada"

print_success "🎉 Proyecto $PROJECT_NAME inicializado exitosamente con Akuri!"
print_info "Próximos pasos:"
echo "  1. Configurar variables de entorno (.env)"
echo "  2. Configurar conexión a base de datos"
echo "  3. Revisar documentación OMA en .akuri/"
echo "  4. Ejecutar 'npm run start:dev' para desarrollo"