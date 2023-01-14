# risc-v-demo

## Notes
• __Difference between RV32I and RV32M__  

RV32I is the base integer instruction set for RISC-V. It includes 32-bit integer instructions for arithmetic, logical, and control operations, as well as load and store instructions for accessing memory.

RV32M is the integer multiplication and division extension to the RV32I instruction set. It adds instructions for multiplying and dividing signed and unsigned integers, as well as instructions for multiplying and dividing high-precision integers using the MULH and MULHSU/MULHU instructions.

In summary, RV32I is the base integer instruction set for RISC-V, while RV32M is an optional extension that adds support for integer multiplication and division operations.

• __Meaning of `sext` in the documentation__  

`sext` stands for "sign-extend". In computer science, sign-extending refers to the operation of extending the sign of a number by adding a number of additional bits to the left of the number. `For example, if you have a 8-bit number with the sign bit set (i.e., it is a negative number), and you want to sign-extend it to 16 bits, you would add 8 bits to the left of the number and set them all to 1.` This would preserve the sign of the number and allow it to be represented in a wider word size.  
In the context of RISC-V, sign-extending is often used to extend the range of a signed immediate value that is used in an instruction. For example, if an instruction has a 12-bit signed immediate field, sign-extending it would allow it to represent a wider range of values. Sign-extending is also often used when loading values from memory into registers, as it allows the value to be sign-extended to the full width of the register.

## Instructions for RV32I
### BGE
```
bge rs1, rs2, offset
```
Take the branch if registers rs1 is greater than or equal to rs2, using signed comparison.
```
if (x[rs1] >=s x[rs2]) pc += sext(offset)
```
Here `>=s` means signed comparison, `>=u` refer to unsigned comparison.  

Similarly, there are beq, beqz, bne, bge, blt, bgeu, bltu.

### LA & LW
The la (load address) instruction is useful for loading the address of a memory location into a register, which can then be used to access the contents of that memory location using load or store instructions. It is often used in combination with the lw (load word) instruction to load a word from memory into a register.

For example, to load a word from memory into the t0 register using the address stored in t1, you could use the following instructions:

```
la t0, label
lw t0, 0(t0)
```

### LW & SW
lw (load word): from memory to register  
sw (store word): from register to memory

## ABI
In the RISC-V instruction set, the ABI (Application Binary Interface) name of a register is the name used to refer to the register in a specific calling convention. A calling convention is a set of rules that define how function calls and returns are made in a program, including which registers are used to pass arguments and return values.

## Calling Convention
Callee may change the value:  
`ra`: return address, which is `x1`.  
`a0` ~ `a7`: argument registers, which is `x10` ~ `x17`.  
`t0` ~ `t6`

Callee will keep the value:  
`sp`  
`s0` ~ `s11`

## Registers
t0 ~ t2: x5 ~ x7  
t3 ~ t6: x28 ~ x31  
s0 ~ s1: x8 ~ x9  
s2 ~ s11: x18 ~ x27

## Code Snippet
### if else
```
beq t0, t1, true
# Execute code for else
j end
true:
# Execute code for if
end:
```