RGBASM = rgbasm
RGBLINK = rgblink

ASM_SRC = Final_words.asm
OBJ_FILE = Final_words.o
GB_FILE = Final_words.gb
MAP_FILE = Final_words.map

HEX_FILE = Final_words_machinecode.hex
HEX_TXT = Final_words_machinecode.txt
BIN_FILE = Final_words_machinecode.bin

all: $(GB_FILE)

$(OBJ_FILE): $(ASM_SRC)
	$(RGBASM) -o $(OBJ_FILE) $(ASM_SRC)

$(GB_FILE): $(OBJ_FILE)
	$(RGBLINK) -o $(GB_FILE) $(OBJ_FILE)
	$(RGBLINK) -m $(MAP_FILE) $(OBJ_FILE)

hex: $(GB_FILE) $(MAP_FILE)
	@SIZE=$$(awk '/bytes used/ {print $$2}' $(MAP_FILE) 2>/dev/null || echo "109"); \
	dd if=$(GB_FILE) bs=1 count=$$SIZE 2>/dev/null | hexdump -v -e '16/1 "%02x " "\n"' > $(HEX_FILE)
	@wc -c $(HEX_FILE)

hex-txt: $(GB_FILE) $(MAP_FILE)
	@SIZE=$$(awk '/bytes used/ {print $$2}' $(MAP_FILE) 2>/dev/null || echo "109"); \
	dd if=$(GB_FILE) bs=1 count=$$SIZE 2>/dev/null | hexdump -v -e '/1 "%02x"' > $(HEX_TXT)
	@wc -c $(HEX_TXT)

bin: $(GB_FILE) $(MAP_FILE)
	@SIZE=$$(awk '/bytes used/ {print $$2}' $(MAP_FILE) 2>/dev/null || echo "109"); \
	dd if=$(GB_FILE) bs=1 count=$$SIZE 2>/dev/null > $(BIN_FILE)
	@ls -lh $(BIN_FILE)

get-hex: hex-txt
	@cat $(HEX_TXT)

hex-dump: $(GB_FILE) $(MAP_FILE)
	@SIZE=$$(awk '/bytes used/ {print $$2}' $(MAP_FILE) 2>/dev/null || echo "109"); \
	dd if=$(GB_FILE) bs=1 count=$$SIZE 2>/dev/null | hexdump -C

size: $(GB_FILE) $(MAP_FILE)
	@SIZE=$$(awk '/bytes used/ {print $$2}' $(MAP_FILE) 2>/dev/null || echo "109"); \
	echo "Total size: $$SIZE bytes"
	@cat $(MAP_FILE) | grep -A 5 "SUMMARY:" || true

clean:
	rm -f $(OBJ_FILE) $(GB_FILE) $(MAP_FILE) $(HEX_FILE) $(HEX_TXT) $(BIN_FILE)

re: clean all

.PHONY: all hex hex-txt get-hex hex-dump bin size clean re
