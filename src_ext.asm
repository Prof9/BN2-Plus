.org fspace

.align 2
fillTileMap:
	push	r14
	
	mov	r2,0x2		// bg
	mov	r3,0x13		// tile

@@bgloop:
	lsl	r3,r3,0x8
	add	r3,0x58-0x1
	mov	r1,0x14-0x1	// y

@@yloop:
	mov	r0,0x1E-0x1	// x

@@xloop:
	push	r0-r3
	bl	sub_setTile
	pop	r0-r3
	sub	r3,0x1
	sub	r0,0x1
	bge	@@xloop
	
	sub	r1,0x1
	bge	@@yloop
	
	mov	r3,0x2
	sub	r2,0x1
	bgt	@@bgloop
	
	pop	r15

.align 2
sub_setTile:
	ldr	r4,=0x08001774|0x1
	bx	r4


.align 2
animJackIn:
	push	r14
	ldrb	r3,[r5,0x2]
	sub	r1,r1,0x4
	lsr	r0,r1,0x2
	add	r2,=data_animJackIn_length
	ldrb	r0,[r2,r0]
	cmp	r3,r0
	bge	animJackIn_next
	add	r0,r3,0x1
	strb	r0,[r5,0x2]
	
	; Set DISPCNT.
	mov	r1,r10
	ldr	r1,[r1,0x10]
	mov	r0,0x1
	and	r0,r3
	lsl	r0,r0,0x5
	mov	r4,r0
	add	r0,0x34
	lsl	r0,r0,0x4
	strh	r0,[r1]
	
	; Decompress frame tiles.
	mov	r0,0x7
	and	r3,r0
	lsl	r0,r3,0x2
	add	r1,=data_jackIn_frame
	ldr	r0,[r1,r0]
	ldr	r1,=0x02011000
	push	r1,r3-r4
	swi	11h
	pop	r0,r3-r4
	
	; Copy frame tiles to VRAM.
	mov	r1,0x6
	lsl	r1,r1,0x18
	lsr	r2,r4,0x1
	add	r2,r4,r2
	lsl	r2,r2,0x9
	add	r1,r1,r2
	mov	r2,0x4B
	lsl	r2,r2,0x8
	push	r4
	bl	sub_memcpy
	pop	r4
	
	; Copy frame palette to VRAM.
	add	r0,=data_jackIn_pal
	lsl	r1,r3,0x5
	add	r0,r0,r1
	ldr	r1,=0x02009090
	add	r1,r1,r4
	mov	r2,0x20
	bl	sub_memcpy
	
	pop	r15

.align 2
sub_memcpy:
	ldr	r4,=0x08000B50|0x1
	bx	r4

.align 2
animJackIn_next:
	add	r0,=data_animJackIn_end
	ldr	r0,[r0,r1]
	bx	r0


.align 2
endJackIn:
	push	r14
	
	ldr	r1,=0x02006348
	mov	r0,0x1
	strh	r0,[r1]
	
	ldr	r0,=0x08023932|0x1
	bx	r0


data_animJackIn_length:
	db	0x1C
	db	0x1C+0x6

.align 4
data_animJackIn_end:
	dw	0x0802398C|0x1
	dw	0x080239B0|0x1

.pool



.align 4
data_jackIn_frame:
	dw	data_jackIn_frame0
	dw	data_jackIn_frame1
	dw	data_jackIn_frame2
	dw	data_jackIn_frame3
	dw	data_jackIn_frame4
	dw	data_jackIn_frame5
	dw	data_jackIn_frame6
	dw	data_jackIn_frame7

.align 4
data_jackIn_pal:
	.import "jackin\pal0.bin"
	.import "jackin\pal1.bin"
	.import "jackin\pal2.bin"
	.import "jackin\pal3.bin"
	.import "jackin\pal4.bin"
	.import "jackin\pal5.bin"
	.import "jackin\pal6.bin"
	.import "jackin\pal7.bin"

.align 4
data_jackIn_frame0:
	.import "jackin\frame0.bin"
.align 4
data_jackIn_frame1:
	.import "jackin\frame1.bin"
.align 4
data_jackIn_frame2:
	.import "jackin\frame2.bin"
.align 4
data_jackIn_frame3:
	.import "jackin\frame3.bin"
.align 4
data_jackIn_frame4:
	.import "jackin\frame4.bin"
.align 4
data_jackIn_frame5:
	.import "jackin\frame5.bin"
.align 4
data_jackIn_frame6:
	.import "jackin\frame6.bin"
.align 4
data_jackIn_frame7:
	.import "jackin\frame7.bin"