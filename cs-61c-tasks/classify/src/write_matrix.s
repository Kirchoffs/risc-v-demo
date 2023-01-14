.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 89
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 90
# - If you receive an fwrite error or eof,
#   this function terminates the program with error code 92
# ==============================================================================
write_matrix:

    # Prologue
    addi sp, sp, -24
    sw ra, 20(sp)
    sw s0, 16(sp)
    sw s1, 12(sp)
    sw s2, 8(sp)
    sw s3, 4(sp)
    sw s4, 0(sp)

    mv s0, a0 # filename
    mv s1, a1 # pointer to matrix in memory
    mv s2, a2 # row
    mv s3, a3 # col

    # Open the file
    mv a1, s0
    li a2, 1
    jal fopen
    blt a0, x0, exp_fopen
    mv s0, a0 # file descriptor

    # Write row and col
    addi sp, sp, -8
    sw s3, 4(sp)
    sw s2, 0(sp)
    mv a1, s0
    mv a2, sp
    li a3, 2
    li a4, 4
    jal fwrite
    li a3, 2
    bne a0, a3, exp_fwrite
    addi sp, sp, 8

    # Write matrix data
    mv a1, s0
    mv a2, s1
    mv a3, s2
    mul a3, a3, s3
    mv s4, a3
    li a4, 4
    jal fwrite
    bne a0, s4, exp_fwrite

    mv a1, s0
    jal fclose
    bne a0, x0, exp_close

    # Epilogue
    lw ra, 20(sp)
    lw s0, 16(sp)
    lw s1, 12(sp)
    lw s2, 8(sp)
    lw s3, 4(sp)
    lw s4, 0(sp)
    addi sp, sp, 24
    ret

exp_fopen:
    li a1, 89
    call exit2

exp_fwrite:
    li a1, 92
    call exit2

exp_close:
    li a1, 90
    call exit2