.globl zero_one_loss

.text
# =======================================================
# FUNCTION: Return a 0-1 classifer array
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the result (loss) array

# Returns:
#   NONE
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 123.
# =======================================================
zero_one_loss:
    bge x0, a2, exp

loop_start:
    mv t0, x0

loop_continue:
    bge t0, a2, loop_end

    mv t1, t0
    slli t1, t1, 2
    add t1, t1, a0
    lw t1, 0(t1)

    mv t2, t0
    slli t2, t2, 2
    add t2, t2, a1
    lw t2, 0(t2)

    mv t3, t0
    slli t3, t3, 2
    add t3, t3, a3
    li t4, 1
    sw t4, 0(t3)

    beq t1, t2, index_increase
    li t4, 0
    sw t4, 0(t3)

index_increase:
    addi t0, t0, 1
    j loop_continue
    
loop_end:
    ret

exp:
    li a1, 123
    call exit2