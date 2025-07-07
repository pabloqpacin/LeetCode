cmake_minimum_required(VERSION 3.10)
project(LeetCode CXX)

# Configurar estándar C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Opciones de compilación
option(BUILD_TESTS "Build test executables" ON)
option(ENABLE_DEBUG "Enable debug mode" OFF)

# Configurar flags de compilación
if(ENABLE_DEBUG)
    set(CMAKE_BUILD_TYPE Debug)
    add_compile_definitions(DEBUG)
else()
    set(CMAKE_BUILD_TYPE Release)
endif()

# Flags de compilación
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")

# Encontrar todos los archivos fuente
file(GLOB_RECURSE SOURCES "src/*.cpp")

# Crear ejecutables para cada archivo fuente
foreach(SOURCE ${SOURCES})
    # Obtener nombre del archivo sin extensión
    get_filename_component(TARGET_NAME ${SOURCE} NAME_WE)
    
    # Crear ejecutable
    add_executable(${TARGET_NAME} ${SOURCE})
    
    # Configurar propiedades del target
    set_target_properties(${TARGET_NAME} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    )
    
    # Agregar a lista de tests si está habilitado
    if(BUILD_TESTS)
        add_test(NAME ${TARGET_NAME} COMMAND ${TARGET_NAME})
    endif()
endforeach()

# Target personalizado para ejecutar todos los tests
add_custom_target(run-all-tests
    COMMAND ${CMAKE_COMMAND} -E echo "Ejecutando todos los tests..."
    COMMAND ${CMAKE_COMMAND} -E echo "---"
    DEPENDS ${SOURCES}
)

# Configurar tests para ejecutarse automáticamente
foreach(SOURCE ${SOURCES})
    get_filename_component(TARGET_NAME ${SOURCE} NAME_WE)
    add_custom_command(TARGET run-all-tests
        COMMAND ${CMAKE_COMMAND} -E echo "Ejecutando ${TARGET_NAME}..."
        COMMAND $<TARGET_FILE:${TARGET_NAME}>
        COMMAND ${CMAKE_COMMAND} -E echo "---"
    )
endforeach()

# Mensaje de información
message(STATUS "Archivos fuente encontrados: ${SOURCES}")
message(STATUS "Modo de compilación: ${CMAKE_BUILD_TYPE}")
message(STATUS "Tests habilitados: ${BUILD_TESTS}")

# Instrucciones de uso
message(STATUS "")
message(STATUS "Para compilar:")
message(STATUS "  mkdir build && cd build")
message(STATUS "  cmake ..")
message(STATUS "  make")
message(STATUS "")
message(STATUS "Para ejecutar tests:")
message(STATUS "  make run-all-tests")
message(STATUS "")
message(STATUS "Para modo debug:")
message(STATUS "  cmake -DENABLE_DEBUG=ON ..") 