.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 58
# =======================================================
dot:
    bge x0, a2, exp1
    bge x0, a3, exp2
    bge x0, a4, exp2

    # Prologue
    addi sp, sp, -4
    sw ra, 0(sp)

loop_start:
    mv t0, x0 # index for v0
    mv t1, x0 # index for v1
    mv t2, x0 # counter
    mv t6, x0 # result

loop_continue:
    bge t2, a2, loop_end

    slli t3, t0, 2 # op for v0
    slli t4, t1, 2 # op for v1
    slli t5, t2, 2 # op for result
    add t3, a0, t3
    add t4, a1, t4
    add t5, a0, t5

    lw t3, 0(t3)
    lw t4, 0(t4)
    mul t3, t3, t4
    add t6, t6, t3

    add t0, t0, a3
    add t1, t1, a4
    addi t2, t2, 1

    j loop_continue
    
loop_end:
    mv a0, t6

    # Epilogue
    lw ra 0(sp)
    addi sp, sp, 4

    ret

exp1:
    li a1, 57
    call exit2

exp2:
    li a1, 58
    call exit2