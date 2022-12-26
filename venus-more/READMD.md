# Notes

## Venus
Enable calling convention checker
```
>> java -jar venus.jar -cc cc_test.s
```

## RISCV Grammar
### Directive .asciiz
In RISC-V assembly language, the .asciiz directive is used to declare a null-terminated string of ASCII characters. A null-terminated string is a sequence of characters that is terminated with a null character (ASCII code 0).

The .asciiz directive is similar to the .ascii directive, which is used to declare a string of ASCII characters. The difference is that the .asciiz directive adds a null character to the end of the string, while the .ascii directive does not.

```
.data
hello: .asciiz "Hello, world!\n"
```

## Example
### discrete_fn.s
```
>> java -jar venus.jar discrete_fn.s 
```

### cc_test.s
Enable calling convention checker
```
>> java -jar venus.jar -cc cc_test.s
```