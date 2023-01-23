.import ../src/utils.s
.import ../src/read_matrix.s
.import ../src/write_matrix.s
.import ../src/matmul.s
.import ../src/relu.s
.import ../src/argmax.s
.import ../src/dot.s

.data
program: .asciiz "main.s"
m0: .asciiz "/Users/yonghaoshu/Documents/projects/risc-v-demo/cs-61c-tasks/classify/inputs/larger0/bin/m0.bin"
m1: .asciiz "/Users/yonghaoshu/Documents/projects/risc-v-demo/cs-61c-tasks/classify/inputs/larger0/bin/m1.bin"
input: .asciiz "/Users/yonghaoshu/Documents/projects/risc-v-demo/cs-61c-tasks/classify/inputs/larger0/bin/inputs/input0.bin"
output: .asciiz "/Users/yonghaoshu/Documents/projects/risc-v-demo/cs-61c-tasks/classify/outputs/test_basic_main/reference0.bin"
args: .word program, m0, m1, input, output

# m0: 3x3
# m1: 3x3
# input: 3x1

# m0 * input => 3x1
# ReLU(m0 * input) => 3x1
# m1 * ReLU(m0 * input) => 3x1

.text
li a0, 5
la a1, args
li a2, 0

classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero,
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # Exceptions:
    # - If there are an incorrect number of command line args,
    #   this function terminates the program with exit code 72
    # - If malloc fails, this function terminates the program with exit code 88
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    li t0, 5
    bne a0, t0, exp_args

    addi sp, sp, -52
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)
    sw s10, 44(sp)
    sw s11, 48(sp)

    mv s0, a1   # s0 for filenames
    mv s11, a2

	# =====================================
    # LOAD MATRICES
    # =====================================

    # Load pretrained m0
    ## allocate space for row of m0
    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s1, a0   # s1 for m0 row

    ## allocate space for col of m0
    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s2, a0   # s2 for m0 col

    ## read m0
    lw a0, 4(s0)
    mv a1, s1
    mv a2, s2
    jal read_matrix
    mv s3, a0   ### s3 for m0 data
                ### s1 for row, s2 for col
    lw s4, 0(s1)
    mv a0, s1
    jal free
    mv s1, s4

    lw s4, 0(s2)
    mv a0, s2
    jal free
    mv s2, s4

    # Load pretrained m1
    ## allocate space for row of m1
    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s4, a0   # s4 for m1 row

    ## allocate space for col of m1
    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s5, a0   # s5 for m1 col

    ## read m1
    lw a0, 8(s0)
    mv a1, s4
    mv a2, s5
    jal read_matrix
    mv s6, a0   ### s6 for m1 data
                ### s4 for m1 row, s5 for m1 col
    lw s7, 0(s4)
    mv a0, s4
    jal free
    mv s4, s7

    lw s7, 0(s5)
    mv a0, s5
    jal free
    mv s5, s7

    # Load input matrix
    ## allocate space for row of input
    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s7, a0   # s7 for input row

    ## allocate space for col of input
    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s8, a0   # s8 for input col

    ## read input
    lw a0, 12(s0)
    mv a1, s7
    mv a2, s8
    jal read_matrix
    mv s9, a0   ### s9 for input data
                ### s7 for input row, s8 for input col
    lw s10, 0(s7)
    mv a0, s7
    jal free
    mv s7, s10

    lw s10, 0(s8)
    mv a0, s8
    jal free
    mv s8, s10

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    mv a0, s1
    mul a0, a0, s8
    slli a0, a0, 2
    jal malloc
    beq a0, x0, exp_malloc
    mv s10, a0  ### s10 for m0 * input
                ### s1 for row, s8 for col

    mv a0, s3   # s3 for m0
    mv a1, s1   # s1 for m0 row
    mv a2, s2   # s2 for m0 col
    mv a3, s9   # s9 for input
    mv a4, s7   # s7 for input row
    mv a5, s8   # s8 for input col
    mv a6, s10 
    jal matmul

    mv t0, s1
    mul t0, t0, s8
    mv a0, s10
    mv a1, t0
    jal relu    ### s10 for m0 * input
                ### s1 for row, s8 for col

    mv a0, s3   # free s3
    jal free

    mv t0, s4
    mul t0, t0, s8
    mv a0, t0
    slli a0, a0, 2
    jal malloc
    beq a0, x0, exp_malloc
    mv s3, a0   ### s3 for m1 * ReLU(m0 * input)
                ### s4 for row, s8 for col

    mv a0, s6   # s6 for m1
    mv a1, s4   # s4 for m1 row
    mv a2, s5   # s5 for m1 col
    mv a3, s10  # s10 for ReLU
    mv a4, s1   # s1 for ReLU row
    mv a5, s8   # s8 for ReLU col
    mv a6, s3
    jal matmul

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0, 16(s0)
    mv a1, s3
    mv a2, s4
    mv a3, s8
    jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0, s3
    mv a1, s4
    mul a1, a1, s8
    jal argmax

    mv a1, a0
    mv s0, a0
    jal print_int

    # Print newline afterwards for clarity
    li a1, '\n'
    jal print_char

free_memory:
    mv a0, s3
    jal free

    mv a0, s6
    jal free
    
    mv a0, s9
    jal free

    mv a0, s10
    jal free

    mv a0, s0

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    lw s11, 48(sp)
    addi sp, sp, 52

    jal exit

exp_args:
    li a1, 72
    call exit2

exp_malloc:
    li a1, 88
    call exit2