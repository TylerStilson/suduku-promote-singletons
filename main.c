#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

uint64_t read_board(char *input, uint16_t *board);
void print_board(uint16_t *board);
void make_pencil_table(uint8_t *table);
void calc_pencil(uint16_t *board, uint8_t *table);
bool promote_pencil_singletons(uint16_t *board, uint8_t *table);

int main(void) {
    // read the board from standard in
    char raw[256];
    printf("Enter the starting board\n");
    fflush(stdout);
    if (fgets(raw, 256, stdin) == NULL) {
        printf("Error reading input string\n");
        return 1;
    }

    // replace the newline at the end with a null byte
    int len = strlen(raw);
    if (len > 0 && raw[len-1] == '\n')
        raw[len-1] = 0;

    // convert the input string to the board format
    uint16_t board[81];
    int status = read_board(raw, board);
    switch (status) {
    case 0:
        // success, nothing to do
        break;
    case 1:
        // input too short
        printf("Input too short: expected exactly 81 characters\n");
        return 1;
    case 2:
        // bad input character
        printf("Bad character found in input: expecting only . and digits 1-9\n");
        return 1;
    case 3:
        // input too long
        printf("Input too long: expected exactly 81 characters\n");
        return 1;
    default:
        printf("Unknown error parsing input board\n");
        return 1;
    }

    // print the board with no pencil marks
    printf("\nBoard before pencil marks calculated:\n");
    print_board(board);

    // generate the lookup table
    uint8_t table[9*9*3];
    make_pencil_table(table);

    // calculate pencil markings
    calc_pencil(board, table);

    // print the board with pencil marks
    printf("\nBoard with pencil marks:\n");
    print_board(board);

    // promote pencil singletons
    bool changed = promote_pencil_singletons(board, table);
    if (changed) {
        printf("\nBoard with pencil singletons promoted:\n");
        print_board(board);
    }

    return 0;
}
