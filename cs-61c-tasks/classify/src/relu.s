.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# ==============================================================================
relu:
    mv t0, x0
    mv t1, a0
    mv t2, a1
    bge t0, t2, exp

    # Prologue
    addi sp, sp, -4
    sw ra, 0(sp)
    
loop_start:
    bge t0, t2, loop_end

loop_continue:
    slli t3, t0, 2
    add t3, t3, t1
    lw a0, 0(t3)

    bge a0, x0, save_back
    mv a0, x0

save_back:
    sw a0, 0(t3)
    addi t0, t0, 1
    j loop_start

loop_end:
    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4

	ret

exp:
    li a1, 57
    call exit2