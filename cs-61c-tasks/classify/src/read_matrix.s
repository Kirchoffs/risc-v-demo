.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 89
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 90
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91
# ==============================================================================
read_matrix:
    # Prologue
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

    mv s0, a0
    mv s1, a1              # pointer to an integer which contains row
    mv s2, a2              # pointer to an integer which contains col

    # open file
    mv a1, s0              # filepath
    li a2, 0               # read premission 0
    jal fopen
    blt a0, x0, exp_fopen
    mv s3, a0              # s3 store the file descriptor

    # malloc
    li a0, 8               # two integers for row and col
    jal malloc
    beq a0, x0, exp_malloc
    mv s0, a0

    # read file row and col
    mv a1, s3              # file descriptor
    mv a2, a0              # pointer to the allocated memory
    li a3, 8               # read 8 bytes
    jal fread           
    li s4, 8
    bne a0, s4, exp_fread

    lw s6, 0(s0)           # row 
    sw s6, 0(s1)           # s1 points to row
    lw s7, 4(s0)           # col
    sw s7, 0(s2)           # s2 points to col
    mul s4, s6, s7
    slli s4, s4, 2
    mv a0, s4
    jal malloc
    mv s0, a0

    mv a1, s3
    mv a2, a0
    mv a3, s4
    jal fread
    bne a0, s4, exp_fread

    mv s8, s0              # s8 is the pointer to the following address

    mv a1, s3
    jal fclose
    bne a0, x0, exp_fclose

    mv a0, s8
    mv a1, s1
    mv a2, s2

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

exp_malloc:
    li a1, 88
    call exit2

exp_fopen:
    li a1, 89
    call exit2

exp_fclose:
    li a1, 90
    call exit2
    
exp_fread:
    li a1, 91
    call exit2