.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# =================================================================
argmax:
    bge x0, a1, exp

    # Prologue
    addi sp, sp, -4
    sw ra, 0(sp)

loop_start:
    mv t0, x0    # index
    mv t1, x0    # candidate
    lw t2, 0(a0) # candidate's value
     
loop_continue:
    beq t0, a1, loop_end
    slli t3, t0, 2
    add t4, a0, t3
    lw t5, 0(t4)
    bge t2, t5, add_index
    mv t1, t0
    mv t2, t5

add_index:
    addi t0, t0, 1
    j loop_continue

loop_end:
    mv a0, t1

    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4

    ret

exp:
    li a1, 57
    call exit2