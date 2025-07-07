# LeetCode C++ Project

[![CI/CD Pipeline](https://github.com/pabloqpacin/LeetCode/actions/workflows/ci.yml/badge.svg)](https://github.com/pabloqpacin/LeetCode/actions/workflows/ci.yml)

Proyecto de soluciones de LeetCode en C++ con automatización completa de compilación, testing y CI/CD.

## 🚀 Herramientas de Automatización

> [!NOTE]
> Prefiero `make`


<!-- 
Resumen de las Opciones de Automatización
Te he creado 4 herramientas diferentes para automatizar tu proceso de compilación:
1. Script Bash (scripts/compile_file.sh)
✅ Más simple: Solo ejecutar ./scripts/compile_file.sh src/hello_world.cpp
✅ Interactivo: Pregunta si quieres ejecutar después de compilar
✅ Opciones flexibles: Debug, optimizaciones, warnings
✅ Colores: Output colorido y fácil de leer
2. Makefile (Makefile)
✅ Tradicional: Herramienta nativa de C/C++
✅ Automático: Detecta todos los archivos .cpp en src/
✅ Múltiples targets: make, make debug, make test, make clean
✅ Eficiente: Solo recompila lo que cambió
3. CMake (CMakeLists.txt)
✅ Moderno: Estándar de la industria
✅ Portable: Funciona en Linux, macOS, Windows
✅ CI/CD: Excelente para GitHub Actions
✅ Escalable: Para proyectos grandes
4. GitHub Actions (.github/workflows/ci.yml)
✅ CI/CD completo: Compila automáticamente en cada push
✅ Múltiples compiladores: GCC y Clang
✅ Tests automáticos: Ejecuta todos los programas
✅ Análisis de código: cppcheck, formato, seguridad

Próximos Pasos
¿Qué te gustaría hacer ahora?
- Probar el script bash: chmod +x scripts/compile_file.sh && ./scripts/compile_file.sh src/hello_world.cpp
- Probar Makefile: make o make test
- Configurar CMake: mkdir build && cd build && cmake .. && make
- Configurar GitHub Actions: Subir a GitHub para activar CI/CD
Agregar más archivos de ejemplo para probar la automatización
 -->

### 1. Script Bash (Simple)
```bash
# Compilar archivo específico
./scripts/compile_file.sh src/hello_world.cpp

# Con opciones de debug
./scripts/compile_file.sh src/hello_world.cpp -d

# Con optimizaciones y warnings
./scripts/compile_file.sh src/hello_world.cpp -o -w

# Ver ayuda
./scripts/compile_file.sh -h
```

### 2. Makefile (Tradicional)
```bash
# Compilar todos los archivos
make

# Compilar con debug
make debug

# Compilar con optimizaciones
make release

# Ejecutar todos los tests
make test

# Limpiar archivos generados
make clean

# Ver ayuda
make help
```

### 3. CMake (Moderno)
```bash
# Configurar y compilar
mkdir build && cd build
cmake ..
make

# Con modo debug
cmake -DENABLE_DEBUG=ON ..
make

# Ejecutar tests
make run-all-tests
```

## 📁 Estructura del Proyecto

```
LeetCode/
├── src/                    # Código fuente
│   └── hello_world.cpp
├── bin/                    # Ejecutables compilados
├── build/                  # Archivos de build (CMake)
├── scripts/                # Scripts de automatización
│   └── compile_file.sh
├── .github/workflows/      # CI/CD
│   └── ci.yml
├── Makefile               # Build system tradicional
├── CMakeLists.txt         # Build system moderno
└── README.md
```

## 🧪 Testing

### Tests Automáticos
Todos los ejecutables se ejecutan automáticamente como tests:

```bash
# Con Makefile
make test

# Con CMake
make run-all-tests

# Con script bash
./scripts/compile_file.sh src/hello_world.cpp
# (pregunta si ejecutar automáticamente)
```

### Tests Manuales
```bash
# Ejecutar ejecutable específico
./bin/hello_world

# Ejecutar todos los ejecutables
for exe in bin/*; do
    echo "Ejecutando $exe..."
    ./$exe
    echo "---"
done
```

## 🔄 CI/CD Pipeline

El proyecto incluye un pipeline completo de GitHub Actions que:

- ✅ Compila con múltiples compiladores (GCC, Clang)
- ✅ Compila en modo debug y release
- ✅ Ejecuta tests automáticamente
- ✅ Análisis estático de código (cppcheck)
- ✅ Verificación de formato de código
- ✅ Escaneo de seguridad (Trivy)
- ✅ Sube artefactos compilados

### Triggers del Pipeline
- Push a `main` o `develop`
- Pull requests a `main`

## 🛠️ Desarrollo

### Agregar Nuevo Archivo
1. Crear archivo `.cpp` en `src/`
2. Los sistemas de build lo detectarán automáticamente
3. Compilar con cualquiera de las herramientas

### Ejemplo de Nuevo Archivo
```cpp
// src/fibonacci.cpp
#include <iostream>

int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}

int main() {
    std::cout << "Fibonacci(10) = " << fibonacci(10) << std::endl;
    return 0;
}
```

### Compilar Nuevo Archivo
```bash
# Con script bash
./scripts/compile_file.sh src/fibonacci.cpp

# Con Makefile
make bin/fibonacci

# Con CMake
cd build && make fibonacci
```

## 📊 Comparación de Herramientas

| Característica | Script Bash | Makefile | CMake |
|----------------|-------------|----------|-------|
| Simplicidad | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Flexibilidad | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Portabilidad | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Integración CI/CD | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Dependencias | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

## 🎯 Recomendaciones

### Para Proyectos Pequeños
- **Script Bash**: Rápido y simple
- **Makefile**: Tradicional y confiable

### Para Proyectos Medianos/Grandes
- **CMake**: Moderno, portable, excelente para CI/CD

### Para CI/CD
- **CMake + GitHub Actions**: Automatización completa

## 🔧 Configuración Adicional

### Instalar Dependencias
```bash
# Ubuntu/Debian
sudo apt-get install build-essential cmake

# macOS
brew install cmake

# Windows (WSL)
sudo apt-get install build-essential cmake
```

### Configurar Git Hooks (Opcional)
```bash
# Crear pre-commit hook para compilar automáticamente
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
make clean && make
EOF
chmod +x .git/hooks/pre-commit
```

## 📝 Notas

- Todos los ejecutables se generan en `bin/`
- Los archivos objeto de CMake van en `build/`
- El pipeline de CI/CD se ejecuta automáticamente en GitHub
- Los artefactos compilados se guardan por 7 días en GitHub Actions

¡Elige la herramienta que mejor se adapte a tu flujo de trabajo! 