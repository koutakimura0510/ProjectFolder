COMPILER    = gcc
FILE		= c
CFLAGS      = -g -MMD -MP -std=c11 -Wall -Wextra -Winit-self -Wno-missing-field-initializers
BACKLIBS	=  `sdl2-config --cflags --libs` -lSDL2_image -lSDL2 -lSDL2_ttf -lSDL2_mixer -lpthread
LIBS		=
INCLUDE     = -I ./include/
TARGET      = ./bin/$(shell basename `readlink -f .`)
ZIP			= $(shell basename `readlink -f .`)
SRCDIR	    = ./src
ifeq "$(strip $(SRCDIR))" ""
	SRCDIR  = .
endif
SOURCES     = $(wildcard $(SRCDIR)/*.$(FILE))
OBJDIR      = ./obj
ifeq "$(strip $(OBJDIR))" ""
	OBJDIR  = .
endif
OBJECTS		= $(addprefix $(OBJDIR)/, $(notdir $(SOURCES:.$(FILE)=.o)))
DEPENDS		= $(OBJECTS:.o=.d)

$(TARGET): $(OBJECTS) $(LIBS)
	$(COMPILER) -o $@ $^ $(BACKLIBS)

$(OBJDIR)/%.o: $(SRCDIR)/%.$(FILE)
	-mkdir -p $(OBJDIR)
	$(COMPILER) $(CFLAGS) $(INCLUDE) -o $@ -$(FILE) $< $(BACKLIBS)

all: clean $(TARGET)

run:
	$(TARGET)

install:
	sudo apt install sox
	sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev -libsdl2-mixer-dev libsdl2-net-dev

clean:
	-rm -f $(OBJECTS) $(DEPENDS) $(TARGET)

-include $(DEPENDS)
