fspace	equ 0x087F4B10

.relativeinclude on
.erroronwarning on
.gba
.open roms\in.gba,roms\out.gba,0x08000000

.include src_ext.asm

.org 0x08001560
	dw	0x3E06
	
.org 0x08023878
	dw	endJackIn|0x1

.org 0x08023888
	push	r14
	mov	r0,0x4
	strb	r0,[r5]
	ldr	r1,=0x02006348
	mov	r0,0x4
	strh	r0,[r1]
	bl	@@sub
	b	@@next
@@sub:
	ldr	r0,=fillTileMap|0x1
	bx	r0
	.pool
@@next:
	.fill	0x14 * 0x2

.org 0x080238E0
	.fill	0x2 * 0x2

.org 0x08023928
	dw	animJackIn|0x1
	dw	animJackIn|0x1

.org 0x08023972
	mov	r1,0x10

.org 0x08023996
	mov	r1,0x40

.close