.globl abs

.text
# =================================================================
# FUNCTION: Given an int return its absolute value.
# Arguments:
# 	a0 (int) is input integer
# Returns:
#	a0 (int) the absolute value of the input
# =================================================================
abs:
	# prologue
    addi sp, sp, -4
    sw ra, 0(sp)

	# Return if non-negative
	bge a0, zero, done

	# Negate a0 if negative
	sub a0, x0, a0

done:
    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4
	
	ret
