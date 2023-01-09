.globl initialize_zero

.text
# =======================================================
# FUNCTION: Initialize a zero array with the given length
# Arguments:
#   a0 (int) size of the array

# Returns:
#   a0 (int*)  is the pointer to the zero array
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# - If malloc fails, this function terminats the program with exit code 26.
# =======================================================
initialize_zero:
    bge x0, a0, exp_len
    
    addi sp, sp, -8
    sw ra, 4(sp)
    sw s0, 0(sp)

    mv s0, a0

    slli a0, a0, 2
    jal malloc
    beqz a0, exp_malloc

loop_start:
    mv t0, x0

loop_continue:
    beq t0, s0, loop_end
    slli t1, t0, 2
    add t1, t1, a0
    sw x0, 0(t1)
    addi t0, t0, 1
    j loop_continue

loop_end:
    lw s0, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8

    ret

exp_len:
    li a1, 36
    call exit2

exp_malloc:
    li a1, 26
    call exit2