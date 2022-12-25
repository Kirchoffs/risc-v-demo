# Notes

## Venus Instructions
First, type the command:
```
>> java -jar venus.jar . -dm
```
Then go to the page: https://venus.cs61c.org/, and enter the below command on Venus CLI:
```
>> mount http://localhost:6161 vmfs ...
``` 

## Code Notes
### ex1
```
.data
.word 2, 4, 6, 8
n: .word 9
```

The .data directive tells the assembler to start a new section of data in the program. The .word directive that follows it allocates space in memory for four __word-sized__ values (__4 bytes__ each on most RISC-V architectures) and initializes them with the values 2, 4, 6, and 8.

The second line of the code defines a label called n and allocates space for a single word-sized value, initialized with the value 9. The label n can be used to refer to the address of this memory location in the program.

This data section could be used to store global variables or constants that can be accessed by the program. For example, the program could use load instructions to load the values from this data section into registers, or store instructions to update the values in the data section.

Here is an example of how the program could use the data section defined above:
```
la t0, n
lw t1, 0(t0)
```

This code will load the value of n (which has value 9) into the t1 register using the la and lw instructions. The la instruction loads the address of n into t0, and the lw instruction loads the word (4 bytes) at that address into t1.

### ex2
[1].  
__sw__: from register to memory  
__lw__`: from memory to register

[2].  
Register representing the variable __k__: t0  
Register representing the variable __sum__: s0  

[3].  
Registers acting as pointers to the source and dest arrays: s1 & s2


[4].
```
jal x0, loop
```

The `jal x0, loop` instruction in RISC-V assembly language is an unconditional jump to a label called loop. The jal (jump and link) instruction is used to jump to a different location in the program and store the return address in the x0 register.

In this case, the jal instruction will jump to the address of the loop label and store the address of the instruction following the jal instruction in the x0 register. The x0 register is a special register in the RISC-V instruction set that is typically used to hold the zero value.

### Factorial
[1]. `ret` = `jalr x0, x1, 0`  
```
jalr rd, rs, immediate
```
In this example, the __jalr__ instruction will jump to the address (rs + immediate) and store the return address in the rd register. The rs register should contain the base address of the target subroutine, and the immediate value specifies an offset from that base address.

[2]. Test factorial  
```
>>  java -jar venus.jar factorial.s 
```

### List Map
[1]. `jal ra, create_default_list`  

`jal target_subroutine`  
In the RISC-V instruction set, the jal (jump and link) instruction is used to jump to a subroutine and store the return address in the register ra. The jal instruction takes a single argument, which is a signed immediate value that specifies the offset in bytes to the target subroutine. The target address is calculated by adding the offset to the address of the jal instruction itself.

`jal rd, target_subroutine`  
In this example, the program will jump to the target subroutine and store the return address in the rd register. When the subroutine finishes executing, it can use the jr instruction `jr rd` to return to the calling function by jumping to the address stored in rd.  

[2]. __li__  
load immediate
```
li t0, 42 # t0 = 42
```

[3]. Test list_map  
```
>> java -jar venus.jar list_map.s

9 8 7 6 5 4 3 2 1 0 
81 64 49 36 25 16 9 4 1 0 
80 63 48 35 24 15 8 3 0 -1 
```