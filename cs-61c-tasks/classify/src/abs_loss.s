.globl abs_loss
.import abs.s

.text
# =======================================================
# FUNCTION: Get the absolute difference of 2 int arrays,
#   store in a third array and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the loss array

# Returns:
#   a0 (int)  is the sum of the absolute loss
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 123.
# =======================================================
abs_loss:
    bge x0, a2, exp

    addi sp, sp, -40
    sw ra, 36(sp)
    sw s0, 32(sp)
    sw s1, 28(sp)
    sw s2, 24(sp)
    sw s3, 20(sp)
    sw s4, 16(sp)
    sw s5, 12(sp)
    sw s6, 8(sp)
    sw s7, 4(sp)
    sw s8, 0(sp)

    mv s0, a0 # the pointer to the start of arr0
    mv s1, a1 # the pointer to the start of arr1
    mv s2, a2 # the length of the arrays
    mv s3, a3 # the pointer to the start of the loss array

loop_start:
    mv s4, x0 # index
    mv s8, x0 # sum

loop_continue:
    bge s4, s2, loop_end

    mv s5, s4
    slli s5, s5, 2
    add s5, s5, s0

    mv s6, s4
    slli s6, s6, 2
    add s6, s6, s1

    mv s7, s4
    slli s7, s7, 2
    add s7, s7, s3

    lw s5, 0(s5)
    lw s6, 0(s6)
    sub a0, s5, s6

    addi sp, sp, -4
    sw ra 0(sp)
    jal abs
    lw ra 0(s0)
    addi sp, sp, 4

    sw a0, 0(s7)
    add s8, s8, a0

    addi s4, s4, 1

    j loop_continue

loop_end:
    mv a0, s8

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
    li a1, 123
    call exit2