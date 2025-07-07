#!/usr/bin/env bash

# Script de compilación para C++
# Uso: ./scripts/compile_file.sh [archivo.cpp] [opciones]

set -e  # Salir en caso de error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 [archivo.cpp] [opciones]"
    echo ""
    echo "Opciones:"
    echo "  -d, --debug     Compilar con símbolos de debug"
    echo "  -o, --optimize  Compilar con optimizaciones"
    echo "  -w, --warnings  Mostrar todas las advertencias"
    echo "  -h, --help      Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 src/hello_world.cpp"
    echo "  $0 src/hello_world.cpp -d"
    echo "  $0 src/hello_world.cpp -o -w"
}

# Variables por defecto
SOURCE_FILE=""
DEBUG=false
OPTIMIZE=false
WARNINGS=false

# Parsear argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--debug)
            DEBUG=true
            shift
            ;;
        -o|--optimize)
            OPTIMIZE=true
            shift
            ;;
        -w|--warnings)
            WARNINGS=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            if [[ -z "${SOURCE_FILE}" ]]; then
                SOURCE_FILE="$1"
            else
                echo -e "${RED}Error: Solo se puede especificar un archivo fuente${NC}"
                exit 1
            fi
            shift
            ;;
    esac
done

# Verificar que se proporcionó un archivo
if [[ -z "${SOURCE_FILE}" ]]; then
    echo -e "${RED}Error: Debes especificar un archivo fuente${NC}"
    show_help
    exit 1
fi

# Verificar que el archivo existe
if [[ ! -f "${SOURCE_FILE}" ]]; then
    echo -e "${RED}Error: El archivo '${SOURCE_FILE}' no existe${NC}"
    exit 1
fi

# Crear directorio bin si no existe
mkdir -p bin

# Generar nombre del ejecutable
EXECUTABLE="bin/$(basename "${SOURCE_FILE}" .cpp)"

# Construir flags de compilación
COMPILER_FLAGS="-std=c++17"
LINKER_FLAGS=""

if [[ "${DEBUG}" == true ]]; then
    COMPILER_FLAGS="${COMPILER_FLAGS} -g -DDEBUG"
    echo -e "${YELLOW}Compilando en modo debug...${NC}"
fi

if [[ "${OPTIMIZE}" == true ]]; then
    COMPILER_FLAGS="${COMPILER_FLAGS} -O2"
    echo -e "${YELLOW}Compilando con optimizaciones...${NC}"
fi

if [[ "${WARNINGS}" == true ]]; then
    COMPILER_FLAGS="${COMPILER_FLAGS} -Wall -Wextra -Wpedantic"
    echo -e "${YELLOW}Mostrando todas las advertencias...${NC}"
fi

# Comando de compilación
COMPILE_CMD="g++ ${COMPILER_FLAGS} ${LINKER_FLAGS} -o ${EXECUTABLE} ${SOURCE_FILE}"

echo -e "${YELLOW}Compilando: ${SOURCE_FILE}${NC}"
echo -e "${YELLOW}Comando: ${COMPILE_CMD}${NC}"

# Ejecutar compilación
if eval "${COMPILE_CMD}"; then
    echo -e "${GREEN}✓ Compilación exitosa!${NC}"
    echo -e "${GREEN}Ejecutable: ${EXECUTABLE}${NC}"
    
    # Preguntar si ejecutar
    read -p "¿Ejecutar el programa? (y/n): " -n 1 -r
    echo
    if [[ ${REPLY} =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Ejecutando: ${EXECUTABLE}${NC}"
        echo "---"
        "./${EXECUTABLE}"
        echo "---"
    fi
else
    echo -e "${RED}✗ Error en la compilación${NC}"
    exit 1
fi




