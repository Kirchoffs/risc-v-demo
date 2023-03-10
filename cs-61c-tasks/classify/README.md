# Classify
## Introduction
Project based on RISC-V, coming from `UC Berkeley CS-61C`
```
├── README.md
├── Makefile (for viewing binary files)
├── inputs (test inputs)
├── outputs (some test outputs)
├── reference_outputs (additional test outputs)
├── src
│   ├── tests (contains additional test for partB)
│   ├── abs.s (partA)
│   ├── argmax.s (partA)
│   ├── classify.s (partB)
│   ├── dot.s (partA)
│   ├── main.s (do not modify)
│   ├── matmul.s (partA)
│   ├── read_matrix.s (partB)
│   ├── relu.s (partA)
│   ├── utils.s (do not modify)
│   └── write_matrix.s (partB)
├── tools
│   ├── convert.py (convert matrix files for partB)
│   └── venus.jar (RISC-V simulator)
└── unittests
    ├── assembly (contains outputs from unittests.py)
    ├── framework.py (do not modify)
    └── unittests.py (partA + partB)
    └── studenttests.py (partA)
    └── Makefile (for running tests)
```

## Run
### Sync with Venus
Run the command below:
```
>> java -jar tools/venus.jar . -dm
```
Open https://venus.cs61c.org in the browser, run `mount local prj`, then go back to the terminal where you run the java command, copy the token and paste it into the pop-up window.  

[What is Venus?](https://github.com/kvakil/venus)

### Run the tests
```
>> cd unittests
>> make test-abs
```

## Notes
### Abosolute Value
```
abs:
    # Return if non-negative
    bge a0, zero, done

    # Negate a0 if negative
    sub a0, x0, a0

done:
    ret
```

### Array
We can use two registers to represent an array, the first register a0 stores the address of the start of the array, the second register a1 stores the number of integers in the array.

### ReLU
The ReLU function takes in an integer array and sets every negative value in the array to 0. Positive values in the array are unchanged. In other words, for each element x in the array, ReLU computes max(x, 0).

### Argmax
The argmax function takes in an integer array and returns the index of the largest element in the array. If multiple elements are tied as the largest element, return the smallest index.

### Dot Product
The dot product function takes in two integer arrays, multiplies the corresponding entries of the arrays together, and returns the sum of all the products.  
- Array Strides  
Instead of iterating through every element of the array, what if we want to iterate through every other element, or every third element? To do this, we will define the stride of an array.

### Matrix Multiplication
#### Storing Matrices
We have row-major orders and col-major orders.  
Row-major order means we each row of the matrix consecutively in memory as a 1-dimensional integer array.

#### Matrix Multiplication
The matrix multiplication function takes in two integer matrices A (dimension n × m) and B (dimension m × k) and outputs an integer matrix C (dimension n × k).

To calculate the entry at row i, column j of C, take the dot product of the ith row of A and the jth column of B. Note that this can be done by calling the dot function with the proper strides.

### Loss Functions
The absolute loss function computes and outputs the absolute difference between each pair of corresponding entries, and then outputs the sum of all the absolute differences.  
The squared loss function computes and outputs the square of the difference between each pair of corresponding entries, and then outputs the sum of all the squared differences.  
The zero-one loss function computes whether each pair of corresponding entries is equal, and does not output any sum.

### Classify
- Read three matrices `m0`, `m1`, and `input` from files. The filepaths are provided as an argument.  
- Compute `h = matmul(m0, input)`.  
- Compute `h = relu(h)`.  
- Compute `o = matmul(m1, h)` and write the resulting -matrix to the output file. The output filepath is provided as an argument.  
- Compute and return `argmax(o)`