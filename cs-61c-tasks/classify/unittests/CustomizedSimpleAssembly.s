.import ../src/utils.s
.import ../src/read_matrix.s

.data
filename: .asciiz "/Users/yonghaoshu/Documents/projects/risc-v-demo/cs-61c-tasks/classify/inputs/simple0/bin/inputs/input0.bin"

.text
# main_test function for testing
main_test:
    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s0, a0

    li a0, 4
    jal malloc
    beq a0, x0, exp_malloc
    mv s1, a0

    ebreak
    la a0, filename
    mv a1, s0
    mv a2, s1
    jal read_matrix
    mv s3, a0
    
    lw s4, 0(s0)
    mv a0, s0
    jal free
    mv s0, s4

    lw s4, 0(s1)
    mv a0, s1
    jal free
    mv s1, s4
    
    jal exit

exp_malloc:
    li a1, 101
    call exit2
