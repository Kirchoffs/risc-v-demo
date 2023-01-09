.globl squared_loss

.text
# =======================================================
# FUNCTION: Get the squared difference of 2 int arrays,
#   store in a third array and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the loss array

# Returns:
#   a0 (int)  is the sum of the squared loss
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 123.
# =======================================================
squared_loss:
    bge x0, a2, exp

loop_start:
    mv t0, x0 # index
    mv t1, x0 # sum

loop_continue:
    bge t0, a2, loop_end

    mv t2, t0
    slli t2, t2, 2
    add t2, t2, a0

    mv t3, t0
    slli t3, t3, 2
    add t3, t3, a1

    mv t4, t0
    slli t4, t4, 2
    add t4, t4, a3

    lw t2, 0(t2)
    lw t3, 0(t3)
    sub t5, t2, t3
    mul t5, t5, t5

    sw t5, 0(t4)
    add t1, t1, t5

    addi t0, t0, 1

    j loop_continue

loop_end:
    mv a0, t1
    ret

exp:
    li a1, 123
    call exit2