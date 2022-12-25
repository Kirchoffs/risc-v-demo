.globl factorial

.data
n: .word 5

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    ### Practice ###
    addi t0, a0, 1 # n + 1
    addi t1, x0, 1 # i = 1
    addi t2, x0, 1 # res = 1
loop:
    beq t1, t0, exit
    mul t2, t2, t1
    addi t1, t1, 1
    j loop
exit:
    mv a0, t2
    ret
