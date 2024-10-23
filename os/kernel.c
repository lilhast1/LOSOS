char* VGA_memory = (char *) 0xb8000;
int VGA_SIZE = 80 * 25 * 2;
unsigned int WHITE_BLACK = 0x07;
void main() {
	char hello[] = "DOBRO DOSLI U KERNEL!\n";
	int i = 0, j = 0;
	while (i < VGA_SIZE) {
		VGA_memory[i++] = ' ';
		VGA_memory[i++] = WHITE_BLACK;
	}
	i = 0;
	while (hello[i]) {
		VGA_memory[j] = hello[i++];
		j += 2; 
	}
}