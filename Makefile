# Build all targets and handle dependencies properly
.PHONY: all
all: configure flash

.PHONY: cc
cc: clean configure 

.PHONY: cc
ccf: clean configure flash

configure:
	@mkdir -p build
	@cd build && cmake .. -DCMAKE_TOOLCHAIN_FILE=../arm-gcc-toolchain.cmake && make

flash:
	openocd -f openocd.cfg -c "program build/Labo2.elf verify reset exit"

clean:
	rm -rf build/*
