.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0			# t0 = 0: k
    addi s0, x0, 0			# s0 = 0: sum
    la s1, source			# s1 = start address of source
    la s2, dest				# s2 = start address of dest
loop:
    slli s3, t0, 2			# s3 = t0 * 4
    add t1, s1, s3			# t1 = source + k * 4 (address of source[k])
    lw t2, 0(t1)			# t2 = source[k]
    beq t2, x0, exit		# while (t2 != 0)
    add a0, x0, t2			# 	a0 = t2
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)			#	save t0, t2
    jal square				#	square(a0)
    lw t0, 0(sp)			
    lw t2, 4(sp)
    addi sp, sp, 8			#	load t0, t2			
    add t2, x0, a0			#	t2 = a0 (return value of square)
    add t3, s2, s3			#	t3 = s2 + k * 4 (address of dest[k])
    sw t2, 0(t3)			#	dest[k] = t2
    add s0, s0, t2			#	s0 = s0 + t2
    addi t0, t0, 1			#	t0 ++
    jal x0, loop
square:
    add t0, a0, x0			# t0 = a0
    add t1, a0, x0			# t1 = a0
    addi t0, t0, 1			# t0 = t0 + 1
    addi t2, x0, -1			# t2 = - 1
    mul t1, t1, t2			# t1 = t1 * t2
    mul a0, t0, t1			# a0 = t0 * t1 = (a0 + 1) * (-1) * a0 = - a0 * (a0 + 1)
    jr ra
exit:
    add a0, x0, s0
    add a1, x0, x0
    ecall # Terminate ecall