OUTPUT_FORMAT(elf-i386)
ENTRY(start)
SECTIONS
{
	. = 0x1000
	.text = { *(.code) }
	.data = { *(.data) }
}