# Makefile para proyecto C++
# Uso: make [target]

# Variables
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra
DEBUG_FLAGS = -g -DDEBUG
RELEASE_FLAGS = -O2 -DNDEBUG
SRC_DIR = src
BIN_DIR = bin
BUILD_DIR = build

# Encontrar todos los archivos .cpp
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
TARGETS = $(SOURCES:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%)

# Target por defecto
.PHONY: all clean debug release test help

all: $(TARGETS)

# Crear directorios necesarios
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Regla para compilar ejecutables
$(BIN_DIR)/%: $(BUILD_DIR)/%.o | $(BIN_DIR)
	$(CXX) $< -o $@

# Regla para compilar objetos
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compilación con debug
debug: CXXFLAGS += $(DEBUG_FLAGS)
debug: $(TARGETS)

# Compilación con optimizaciones
release: CXXFLAGS += $(RELEASE_FLAGS)
release: $(TARGETS)

# Limpiar archivos generados
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Ejecutar todos los tests
test: all
	@echo "Ejecutando tests..."
	@for target in $(TARGETS); do \
		echo "Ejecutando $$target..."; \
		./$$target; \
		echo "---"; \
	done

# Mostrar ayuda
help:
	@echo "Makefile para proyecto C++"
	@echo ""
	@echo "Targets disponibles:"
	@echo "  all      - Compilar todos los archivos (por defecto)"
	@echo "  debug    - Compilar con símbolos de debug"
	@echo "  release  - Compilar con optimizaciones"
	@echo "  clean    - Limpiar archivos generados"
	@echo "  test     - Compilar y ejecutar todos los programas"
	@echo "  help     - Mostrar esta ayuda"
	@echo ""
	@echo "Ejemplos:"
	@echo "  make                    # Compilar todos"
	@echo "  make debug              # Compilar con debug"
	@echo "  make bin/hello_world   # Compilar archivo específico"
	@echo "  make clean              # Limpiar"
	@echo "  make test               # Ejecutar tests"

# Mostrar información del proyecto
info:
	@echo "Archivos fuente encontrados:"
	@echo $(SOURCES)
	@echo ""
	@echo "Ejecutables que se generarán:"
	@echo $(TARGETS) 