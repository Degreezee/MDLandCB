T = XXXXXX

help:
	@echo Available goals:
	@echo ' run   - create and run without debugging '
	@echo ' debug - create and debug  '
	@echo ' help  - show this message '
$(T): $(T).asm
	nasm -f elf $(T).asm -l $(T).lst
	 ld -m elf_i386 -o $(T) $(T).o
run: $(T)
	nasm -f elf $(T).asm -l $(T).lst
	 ld -m elf_i386 -o $(T) $(T).o
	./$(T)
debug: $(T)
	edb --run $(T)
