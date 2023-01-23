.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 59
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 59
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 59
# =======================================================
matmul:
    # Error checks
    bge x0, a1, exp
    bge x0, a2, exp
    bge x0, a4, exp
    bge x0, a5, exp
    bne a2, a4, exp

    # Prologue
    addi sp, sp, -40
    sw ra, 36(sp)
    sw s0, 32(sp)   # index for result matrix
    sw s1, 28(sp)   # row index for outer loop
    sw s2, 24(sp)   # col index for inner loop
    sw s3, 20(sp)   # number of rows for result matrix
    sw s4, 16(sp)   # number of cols for result matrix
    sw s5, 12(sp)   # number of elements to calculate one cell
    sw s6, 8(sp)    # the pointer to the start of m0
    sw s7, 4(sp)    # the pointer to the start of m1
    sw s8, 0(sp)    # the pointer to the start of d

    mv s3, a1       # row of m0
    mv s4, a5       # col of m1
    mv s5, a2       # col of m0
    mv s6, a0       # pointer to m0
    mv s7, a3       # pointer to m1
    mv s8, a6       # pointer to d

    mv s0, x0

outer_loop_start:
    mv s1, x0        

outer_loop_continue:
    bge s1, s3, outer_loop_end

inner_loop_start:
    mv s2, x0       

inner_loop_continue:
    bge s2, s4, inner_loop_end

loop_content:
    mul a0, s1, s5 # s1: row index for outer loop; s5: number of cols for m0
    slli a0, a0, 2
    add a0, a0, s6

    mv a1, s2      # s2: col index for inner loop
    slli a1, a1, 2
    add a1, a1, s7 # s7: the pointer to the start of m1

    mv a2, s5

    li a3, 1
    mv a4, s4

    jal dot

    mv t0, s0
    slli t0, t0, 2
    add t0, t0, s8
    sw a0, 0(t0)

    addi s0, s0, 1
    addi s2, s2, 1
    j inner_loop_continue

inner_loop_end:
    addi s1, s1, 1
    j outer_loop_continue

outer_loop_end:
    # Epilogue
    lw ra, 36(sp)
    lw s0, 32(sp) 
    lw s1, 28(sp) 
    lw s2, 24(sp) 
    lw s3, 20(sp)  
    lw s4, 16(sp)  
    lw s5, 12(sp)  
    lw s6, 8(sp)  
    lw s7, 4(sp)  
    lw s8, 0(sp)  
    addi sp, sp, 40

    ret
exp:
    li a1, 59
    call exit2