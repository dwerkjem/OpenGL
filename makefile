CC = g++
CFLAGS = -Wall -Wextra -std=c++11

SRC_DIR = src
BIN_DIR = bin

IMGUI_DIR = src/imgui

IMGUI_SOURCES = $(wildcard $(IMGUI_DIR)/*.cpp)
IMGUI_OBJECTS = $(patsubst $(IMGUI_DIR)/%.cpp,$(BIN_DIR)/%.o,$(IMGUI_SOURCES))

BACKENDS_DIR = src/imgui/backends

BACKENDS_SOURCES = $(wildcard $(BACKENDS_DIR)/*.cpp)
BACKENDS_OBJECTS = $(patsubst $(BACKENDS_DIR)/%.cpp,$(BIN_DIR)/%.o,$(BACKENDS_SOURCES))

GLFW_LIBS = -lglfw -lGL

all: $(BIN_DIR)/run

$(BIN_DIR)/%.o: $(IMGUI_DIR)/%.cpp
	$(CC) $(CFLAGS) -I$(IMGUI_DIR) -I$(BACKENDS_DIR) -c $< -o $@

$(BIN_DIR)/%.o: $(BACKENDS_DIR)/%.cpp
	$(CC) $(CFLAGS) -I$(IMGUI_DIR) -I$(BACKENDS_DIR) -c $< -o $@

$(BIN_DIR)/run: $(SRC_DIR)/main.cpp $(IMGUI_OBJECTS) $(BACKENDS_OBJECTS)
	$(CC) $(CFLAGS) -I$(IMGUI_DIR) -I$(BACKENDS_DIR) $^ -o $@ $(GLFW_LIBS)

clean:
	rm -f $(BIN_DIR)/*.o $(BIN_DIR)/run