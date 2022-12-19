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
```
bge rs1, rs2, offset
```
Take the branch if registers rs1 is greater than or equal to rs2, using signed comparison.
```
if (x[rs1] >=s x[rs2]) pc += sext(offset)
```
Here `>=s` means signed comparison, `>=u` refer to unsigned comparison.