#include <inttypes.h>

void make_pencil_table(uint8_t *table) {
    int i = 0;
    for (int row = 0; row < 81; row += 9)
        for (int col = 0; col < 9; col++)
            table[i++] = row + col;

    for (int col = 0; col < 9; col++)
        for (int row = 0; row < 81; row += 9)
            table[i++] = row + col;

    for (int grow = 0; grow < 81; grow += 27)
        for (int gcol = 0; gcol < 9; gcol += 3)
            for (int row = 0; row < 27; row += 9)
                for (int col = 0; col < 3; col++)
                    table[i++] = grow + row + gcol + col;
}
