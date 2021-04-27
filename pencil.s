                            .global calc_pencil
                            .global calc_pencil_get_used
                            .global calc_pencil_clear_used
                            .global reset_pencils
                            .text

// define all four functions here

reset_pencils:
						// x0: board
						// x1: i
						// x2: elt
						// x3: n

		mov 	x1, #0
		b	5f

2:
		ldrh 	w2, [x0, x1, lsl #1]
		and 	x3, x2, 0x8000
		cmp 	x3, #0
		b.eq 	6f
		mov 	x2, 0b1000001111111110
		b 	6f
5:
		cmp 	x1, #80
		b.le 	2b
		b 	7f
6:
		strh	w2,[ x0, x1, lsl #1]
		add 	x1, x1, #1
		b 	5b
7:
	 	ret

calc_pencil_get_used:

		mov 	x2, #0
		mov	x7, #0
		mov	x8, #1
		b	3f
1:
		ldrb	w3, [x1, x2]
		ldrh 	w4, [x0, x3, lsl #1]
		and 	x5, x4, 0x8000
		cmp	x5, #0
		b.ne	2f
		lsl	x6, x8, x4
		orr	x7, x7, x6
2:
		add 	x2, x2, #1
3:
		cmp	x2, #9
		b.lt	1b
		mov	x0, x7
		ret

calc_pencil_clear_used:

		mov	x3, #0
		b	5f
2:
		ldrb	w4, [x1, x3]
		ldrh	w5, [x0, x4, lsl #1]
		and	x6, x5, 0x8000
		cmp	x6, #0
		b.eq	3f
		bic	x5, x5, x2
3:
		strh	w5, [x0, x4, lsl #1]
		add	x3, x3, #1
5:
		cmp	x3, #9
		b.lt	2b
		ret

calc_pencil:

		stp 	x29, x30, [sp, -16]!
		mov	x29, sp
		sub	sp, sp, #32
		str	x19, [sp, #0]
		str	x20, [sp, #8]
		str	x21, [sp, #16]
		mov	x19, x0
		mov	x20, x1
		mov 	x21, #0
		bl	reset_pencils
		b	5f

2:
		mov	x0, x19
		mov	x1, x20
		add	x1, x1, x21
		
		bl	calc_pencil_get_used

		mov	x2, x0
		mov	x0, x19
		mov 	x1, x20
		add	x1, x1, x21
		
		bl	calc_pencil_clear_used

3:
		add	x21, x21, #9
5:
		cmp	x21, #243
		b.lt	2b

		ldr	x19, [sp, #0]
		ldr	x20, [sp, #8]
		ldr 	x21, [sp, #16]
		add	sp, sp, #32
		ldp	x29, x30, [sp], 16




		ret
