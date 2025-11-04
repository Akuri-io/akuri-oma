# Scripts de Inicialización de Proyectos Akuri

Esta carpeta contiene scripts automatizados para inicializar nuevos proyectos usando los CLIs oficiales de cada framework, configurados con la metodología OMA (Organización Modular Akuri).

## 🚀 Scripts Disponibles

### `init-nestjs-project.sh`
Inicializa un proyecto NestJS con configuración OMA completa.

**Uso:**
```bash
./init-nestjs-project.sh <project-name>
```

**Qué hace:**
- ✅ Crea proyecto con `npx @nestjs/cli new`
- ✅ Instala dependencias comunes (JWT, TypeORM, validation)
- ✅ Crea estructura `.akuri/` con manifiesto
- ✅ Configura estructura OMA (global/, shared/, features/)
- ✅ Crea archivos de configuración (.env, README)

### `init-angular-project.sh`
Inicializa un proyecto Angular con configuración OMA completa.

**Uso:**
```bash
./init-angular-project.sh <project-name>
```

**Qué hace:**
- ✅ Crea proyecto con `ng new` (routing, SCSS)
- ✅ Instala Angular Material y dependencias comunes
- ✅ Crea estructura `.akuri/` con manifiesto
- ✅ Configura estructura OMA con separación lógica vs visual
- ✅ Crea archivos de environment y estilos globales

### `init-flutter-project.sh`
Inicializa un proyecto Flutter con configuración OMA completa.

**Uso:**
```bash
./init-flutter-project.sh <project-name>
```

**Qué hace:**
- ✅ Crea proyecto con `flutter create`
- ✅ Configura Riverpod, Dio, Freezed y otras dependencias OMA
- ✅ Crea estructura `.akuri/` con manifiesto
- ✅ Configura estructura OMA con providers y separación lógica vs visual
- ✅ Crea archivos de configuración y utilidades básicas

## 📋 Requisitos Previos

### Para NestJS:
- Node.js instalado
- npm disponible
- (Opcional) @nestjs/cli instalado globalmente

### Para Angular:
- Node.js instalado
- npm disponible
- Angular CLI instalado: `npm install -g @angular/cli`

### Para Flutter:
- Flutter SDK instalado y configurado
- `flutter doctor` sin errores críticos
- Dart SDK incluido con Flutter

## 🏗️ Estructura Resultante

Después de ejecutar cualquier script, obtendrás:

```
project-name/
├── .akuri/
│   ├── akuri-manifest/
│   │   └── project.manifest.md    # Manifiesto específico del proyecto
│   ├── akuri-specs/               # Especificaciones del proyecto
│   └── akuri-work/                # Trabajo en progreso
├── src/lib/                       # Código fuente (depende del framework)
├── [estructura OMA]               # global/, shared/, features/
├── [archivos de config]           # .env, environments, etc.
└── README.md                      # Documentación del proyecto
```

## 🎯 Metodología OMA Aplicada

Los scripts configuran automáticamente:

- **📁 Estructura jerárquica:** global/ → shared/ → features/
- **📊 Separación lógica vs visual:** En frontend (Angular/Flutter)
- **🏗️ Arquitectura por capas:** Controllers → Services → Models
- **🔧 Configuración completa:** Environments, estilos, dependencias
- **📚 Documentación integrada:** Manifiestos y referencias OMA

## 🚦 Próximos Pasos Después de Inicialización

1. **Configurar variables de entorno** (bases de datos, APIs, etc.)
2. **Revisar documentación OMA** en `.akuri/akuri-methodology/oma/`
3. **Comenzar con BUILD-LOGIC** para el primer feature
4. **Aplicar workflows OMA** para desarrollo estructurado

## 🔍 Verificación Post-Inicialización

Ejecuta los scripts de validación OMA:

```bash
# Validar nomenclatura
.akuri/akuri-methodology/oma/scripts/validate-oma.sh

# Auditar cumplimiento OMA
.akuri/akuri-methodology/oma/scripts/audit-oma.sh
```

## 📞 Soporte

Si encuentras problemas con los scripts:

1. Verifica que los CLIs estén instalados correctamente
2. Revisa los logs de error del script
3. Consulta la documentación OMA específica del framework
4. Reporta issues en el repositorio Akuri

## 🎉 Beneficios

- **⚡ Inicio rápido:** Proyectos listos en minutos
- **🏆 Calidad garantizada:** Configuración OMA desde el inicio
- **📈 Escalabilidad:** Arquitectura preparada para crecimiento
- **🤝 Consistencia:** Todos los proyectos siguen los mismos estándares
- **🔧 Mantenibilidad:** Estructura clara y documentada