                .global read_board
                .text

// read_board(*input, *board) ->
//     0 for success
//     1 for input too short
//     2 for input contains invalid character
//     3 for input too long
//		x0: input
//		x1: board
//		x2: i
//		x3: ch
//		x4: board[i]
//		x5: sub
//		x6: 0 ascii
//		x7: 0x8000

read_board:
		mov	x7, 0x8000
		mov 	x6, #'0'
		mov	x2, #0
		b	6f
4:
		mov 	x0, #2
		ret
10:
		mov	x0, #1
		ret
1:
		ldrb	w3, [x0, x2]
		cmp 	x3, #0
		b.ne 	2f
		b	10b
2:
		cmp 	x3, #'.'
		b.ne	3f
		strh 	w7, [x1, x2, lsl #1]
		add	x2, x2, #1
		b	6f
3:
		cmp	x3, #'1'
		b.lt	4b
		cmp 	x3, #'9'
		b.gt	4b
		sub 	x5, x3, x6
		strh 	w5, [x1, x2, lsl #1]
		add 	x2, x2, #1
6:
		cmp 	x2, #81
		b.lt	1b
7:
		ldrb 	w3, [x0,x2]
		cmp	x3, #0
		b.eq 	8f
		mov 	x0, #3
		ret
8:
		mov 	x0, #0
		ret
