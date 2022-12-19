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