include .env

.PHONY: all
all: paths build deploy pack

.PHONY: paths
paths:
	@echo "Path to Godot executable:\n\t$(GODOT)"
	@echo "Godot bin/ path:\n\t$(GODOT_BIN_PATH)"
	@echo "Build path:\n\t$(BUILD_PATH)"
	@echo "Godot version:\n\t`$(GODOT) --version`"
	@echo "Library name:\n\t$(LIBRARY_NAME)"
	@echo "Executable name:\n\t$(EXECUTABLE_NAME)"
	@echo "Godot project file path:\n\t$(GODOT_PROJECT_FILE_PATH)"

.PHONY: build
build:
	mkdir -p $(BUILD_PATH)
	swift build --product $(LIBRARY_NAME) --build-path $(BUILD_PATH)
	swift build --product $(EXECUTABLE_NAME) --build-path $(BUILD_PATH)

.PHONY: deploy
deploy:
	rm -rf $(GODOT_BIN_PATH)
	mkdir -p $(GODOT_BIN_PATH)

	cp $(BUILD_PATH)/debug/libSwiftGodot.dylib $(GODOT_BIN_PATH)
	cp $(BUILD_PATH)/debug/libMySGBGame.dylib $(GODOT_BIN_PATH)

.PHONY: run
run:
	swift run $(EXECUTABLE_NAME) --build-path $(BUILD_PATH)

.PHONY: open
open:
	$(GODOT) $(GODOT_PROJECT_FILE_PATH)

.PHONY: pack
pack:
	@echo "Going to open Godot to ensure all resources are imported."
	-$(GODOT) $(GODOT_PROJECT_FILE_PATH) --headless --quit
	@echo "Exporting the .pck file"
	$(GODOT) --headless --path $(GODOT_PROJECT_DIRECTORY) --export-pack Packer ../Sources/$(EXECUTABLE_NAME)/Resources/$(LIBRARY_NAME).pck
