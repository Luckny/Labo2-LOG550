cmake_minimum_required(VERSION 3.20)
enable_language(ASM)

project(Labo2 C ASM)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(STARTUP_FILE "Core/Startup/startup_stm32l4s5vitx.s")

# Compiler options
add_compile_options(
  -mcpu=cortex-m4
  -mthumb
  -mfloat-abi=hard
  -mfpu=fpv4-sp-d16
  -DSTM32L4S5xx
  -DUSE_HAL_DRIVER
  -specs=nosys.specs
  -specs=nano.specs
  -u _printf_float
  -lc
)

include_directories(
  Core/Inc
  Drivers/STM32L4xx_HAL_Driver/Inc
  Drivers/CMSIS/Include
  Drivers/CMSIS/Device/ST/STM32L4xx/Include
  Middlewares/Third_Party/FreeRTOS/Source/include
  Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2
  Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F
)

file(GLOB_RECURSE SOURCES
  "Core/Src/*.c"
  "Drivers/STM32L4xx_HAL_Driver/Src/*.c"
  "Middlewares/Third_Party/FreeRTOS/Source/*.c"
  "Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2/*.c"
  "Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/*.c"
  "Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c"
)

add_executable(${PROJECT_NAME}.elf ${SOURCES} ${STARTUP_FILE})

# Corrected linker options
target_link_options(${PROJECT_NAME}.elf PRIVATE
  -T${CMAKE_SOURCE_DIR}/STM32L4S5VITX_FLASH.ld
  -Wl,--gc-sections
  -Wl,--print-memory-usage
  -mcpu=cortex-m4
  -mthumb
  -mfloat-abi=hard
  -mfpu=fpv4-sp-d16
  -specs=nosys.specs
  -u_printf_float  # If using float in printf
)


