                .global promote_pencil_singletons
                .text

// promote_pencil_singletons(*board, *table) ->
//     0 -> no changes made
//     1 -> 1 or more squares solved
promote_pencil_singletons:

						// x19: board
						// x20: table
						// x11: changes
						// x22: overall change
						// x3: i
						// x4: elt
						// x5: pelt
						// x6: n
						// x7: count
						// x8: j
						// x9: shift
						// x10: 1
		stp	x29, x30, [sp, #-16]!
		mov	x29, sp
		sub	sp, sp, #32
		str	x19, [x29, #-32]
		str	x20, [x29, #-24]
		str	x22, [x29, #-16]

		mov	x19, x0
		mov 	x20, x1
		mov 	x11, #0
		mov	x22, #0
2:
		mov	x11, #0
		mov	x3, #0
		b	9f
3:
		ldrh	w4, [x19, x3, lsl #1]
		and	x5, x4, 0x8000
		cmp	x5, #0
		b.eq	8f
		mov	x6, #0
		mov	x7, #0
		mov	x8, #1
		mov	x10, #1
		b	6f
4:
		lsl	x9, x10, x8
		and 	x9, x4, x9
		cmp	x9, #0
		b.eq	5f
		add	x7, x7, #1
		mov	x6, x8
5:
		add	x8, x8, #1
6:
		cmp	x8, #9
		b.le	4b
7:
		cmp	x7, #1
		b.ne	8f
		strh	w6, [x19, x3, lsl #1]
		mov	x11, #1
8:
		add	x3, x3, #1
9:
		cmp	x3, #80
		b.le	3b
10:
		cmp	x11, #1
		b.ne	12f
		add	x22, x22, #1
		mov	x0, x19
		mov	x1, x20
		bl	calc_pencil
		b	2b
12:
		cmp 	x22, #0
		b.gt	13f
		mov 	x0, #0
		b	14f
13:
		mov 	x0, #1
14:
		ldr	x19, [x29, #-32]
		ldr	x20, [x29, #-24]
		ldr	x22, [x29, #-16]
		add	sp, sp, #32
		ldp	x29, x30, [sp], 16
		ret

