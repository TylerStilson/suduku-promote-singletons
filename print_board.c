#include <assert.h>
#include <inttypes.h>
#include <stdio.h>

const int rowsize = 8*9 + 1 + 1;
const int rowcount = 4*9 + 1;

void draw_char(char *buffer, int x, int y, char ch) {
    assert(buffer != NULL);
    assert(x >= 0 && x < rowsize);
    assert(y >= 0 && y < rowcount);
    
    int index = (y * rowsize) +x;
    buffer[index] = ch;

        // your code goes here
}

void print_board(uint16_t *board) {
    // your code goes here
    char buffer [rowsize * rowcount + 1];
    char ch;
    int x, y;
    int i = 0;
    int dx, dy;
    
    for(x=0; x < rowsize; x++){
	    for(y=0; y < rowcount; y++){
		    if (x == (rowsize -1)) {
			    ch = '\n';
			
		    }
		    else if (x % 24 == 0){
			    if (y % 12 == 0){
				ch = '+';     
			    }
			    else{
			    	ch =  '|';
			    }
		    }
		    else if (y % 12 == 0){
				ch = '-';
			}

		    else if (x % 8 == 0) {
			    if(y % 4 ==0) {
			    	ch = '+';
		   	} else if (y % 2 == 1) {
				ch = '|';
			} else {
				ch = ' ';
			}
		    }
		    else if (y % 4 == 0) {
			    if (x % 2 == 0) {
			    	ch = '-';
			    }else {
				ch = ' ';
		    }
		
		    }else{
			    ch = ' ';
		    }
		    draw_char(buffer, x, y, ch);
	    }
    }

	for(y = 0; y <= 8; y++){
		for(x = 0; x <= 8; x++){
			int elt = board[i];
			if ((elt & 0x8000) != 0) {
				int n;
				int j = 2;
				for(n = 1; n <=3; n++){
					if ((elt & (1 << n)) != 0) {
						ch = n + '0';
						dx = (x*8) + j;
						dy = (y*4) + 1;
					} else {
						ch = '.';
						dx = (x*8) + j;
						dy = (y*4) + 1;
					}
					draw_char(buffer, dx, dy, ch);
	
					j = j+2;

				}
				j=2;
				for(n = 4; n <=6; n++){
					if ((elt & (1 << n)) != 0) {
						ch = n + '0';
						dx = (x*8) + j;
						dy = (y*4) + 2;
					} else {
						ch = '.';
						dx = (x*8) + j;
						dy = (y*4) + 2;
					}
					draw_char(buffer, dx, dy, ch);
					j=j+2;
				
				}
				j = 2;
				for(n = 7; n <=9; n++){
					if ((elt & (1 << n)) != 0) {
						ch = n + '0';
						dx = (x*8) + j;
						dy = (y*4) + 3;
					} else {
						ch = '.';
						dx = (x*8) + j;
						dy = (y*4) + 3;
					}	
					draw_char(buffer, dx, dy, ch);
					j = j+2;
				}


			}else {
				if( elt == 0) {
					ch = ' ';
					dx = (x*8)+ 4;
					dy = (x*4) +2;
				}else{
					ch = elt + '0';
					dx = (x*8) + 4;
					dy = (y*4) + 2;
				}
				draw_char(buffer, dx, dy, ch);
			}
			i = i + 1;
			// int dx = (x*8) + 4;
			// int dy = (y*4) + 2;
		}
	}






	    buffer[(rowsize * rowcount) +1] = '0';
	    printf("%s", buffer);
}
