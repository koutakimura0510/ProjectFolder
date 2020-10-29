COMPILER    = gcc
FILE		= c
CFLAGS      = -g -MMD -MP -std=c11 -Wall -Wextra -Winit-self -Wno-missing-field-initializers
THREAD		= -lpthread
GTK 		= (pkg-config --cflags --libs gtk+-3.0)
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
	$(COMPILER) -o $@ $^ $(THREAD) $$$(GTK)

$(OBJDIR)/%.o: $(SRCDIR)/%.$(FILE)
	-mkdir -p $(OBJDIR)
	$(COMPILER) $(CFLAGS) $(INCLUDE) -o $@ -$(FILE) $< $(THREAD) $$$(GTK)

PASS 		= kouta5100

all: clean $(TARGET)

run:
	$(TARGET)

zip:
	zip -P $(PASS) -r $(ZIP) ../$(ZIP)/

clean:
	-rm -f $(OBJECTS) $(DEPENDS) $(TARGET)

-include $(DEPENDS)
