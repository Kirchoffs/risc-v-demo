from unittest import TestCase
from framework import AssemblyTest, print_coverage

"""
Coverage tests for project 2 is meant to make sure you understand
how to test RISC-V code based on function descriptions.
Before you attempt to write these tests, it might be helpful to read
unittests.py and framework.py.
Like project 1, you can see your coverage score by submitting to gradescope.
The coverage will be determined by how many lines of code your tests run,
so remember to test for the exceptions!
"""

"""
abs_loss
# =======================================================
# FUNCTION: Get the absolute difference of 2 int vectors,
#   store in the result vector and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int*) is the pointer to the start of the result vector

# Returns:
#   a0 (int)  is the sum of the absolute loss
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 123.
# =======================================================
"""
class TestAbsLoss(TestCase):
    def test_invalid_n(self):
        t = AssemblyTest(self, "abs_loss.s")

        t.input_scalar("a2", 0)
        t.call("abs_loss")
        
        t.execute(code = 123)
    
    def test_length_1(self):
        t = AssemblyTest(self, "abs_loss.s")

        array0 = t.array([1])
        t.input_array("a0", array0)
        
        array1 = t.array([2])
        t.input_array("a1", array1)
        
        t.input_scalar("a2", 1)
        
        dest_array = t.array([0])
        t.input_array("a3", dest_array)
        
        t.call("abs_loss")
        
        t.check_scalar("a0", 1)
        t.check_array(dest_array, [1])
        # t.check_array_pointer("a3", [1])

        t.execute()
        
    def test_standard(self):
        t = AssemblyTest(self, "abs_loss.s")

        array0 = t.array([5, 2, 3])
        t.input_array("a0", array0)
        
        array1 = t.array([2, 3, 0])
        t.input_array("a1", array1)
        
        t.input_scalar("a2", 3)
        
        dest_array = t.array([0, 0, 0])
        t.input_array("a3", dest_array)
        
        t.call("abs_loss")
        
        t.check_scalar("a0", 7)
        t.check_array(dest_array, [3, 1, 3])

        t.execute()

    @classmethod
    def tearDownClass(cls):
        print_coverage("abs_loss.s", verbose = False)


"""
squared_loss
# =======================================================
# FUNCTION: Get the squared difference of 2 int vectors,
#   store in the result vector and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int*) is the pointer to the start of the result vector

# Returns:
#   a0 (int)  is the sum of the squared loss
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 123.
# =======================================================
"""
class TestSquaredLoss(TestCase):
    def test_invalid_n(self):
        t = AssemblyTest(self, "squared_loss.s")

        t.input_scalar("a2", 0)
        t.call("squared_loss")
        
        t.execute(code = 123)
    
    def test_length_1(self):
        t = AssemblyTest(self, "squared_loss.s")

        array0 = t.array([1])
        t.input_array("a0", array0)
        
        array1 = t.array([2])
        t.input_array("a1", array1)
        
        t.input_scalar("a2", 1)
        
        dest_array = t.array([0])
        t.input_array("a3", dest_array)
        
        t.call("squared_loss")
        
        t.check_scalar("a0", 1)
        t.check_array(dest_array, [1])
        # t.check_array_pointer("a3", [1])

        t.execute()
        
    def test_standard(self):
        t = AssemblyTest(self, "squared_loss.s")

        array0 = t.array([5, 2, 3])
        t.input_array("a0", array0)
        
        array1 = t.array([2, 3, 0])
        t.input_array("a1", array1)
        
        t.input_scalar("a2", 3)
        
        dest_array = t.array([0, 0, 0])
        t.input_array("a3", dest_array)
        
        t.call("squared_loss")
        
        t.check_scalar("a0", 19)
        t.check_array(dest_array, [9, 1, 9])

        t.execute()

    @classmethod
    def tearDownClass(cls):
        print_coverage("squared_loss.s", verbose = False)

"""
zero_one_loss
# =======================================================
# FUNCTION: Generates a 0-1 classifer vector inplace in the result vector,
#  where result[i] = (v0[i] == v1[i])
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int*) is the pointer to the start of the result vector

# Returns:
#   NONE
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 123.
# =======================================================
"""
class TestZeroOneLoss(TestCase):
    def test_invalid_n(self):
        t = AssemblyTest(self, "zero_one_loss.s")

        t.input_scalar("a2", 0)
        t.call("zero_one_loss")
        
        t.execute(code = 123)
    
    def test_length_1_equal(self):
        t = AssemblyTest(self, "zero_one_loss.s")

        array0 = t.array([1])
        t.input_array("a0", array0)
        
        array1 = t.array([1])
        t.input_array("a1", array1)
        
        t.input_scalar("a2", 1)
        
        dest_array = t.array([0])
        t.input_array("a3", dest_array)
        
        t.call("zero_one_loss")
        
        t.check_array(dest_array, [1])
        # t.check_array_pointer("a3", [1])

        t.execute()
        
    def test_length_1_not_equal(self):
        t = AssemblyTest(self, "zero_one_loss.s")

        array0 = t.array([1])
        t.input_array("a0", array0)
        
        array1 = t.array([2])
        t.input_array("a1", array1)
        
        t.input_scalar("a2", 1)
        
        dest_array = t.array([0])
        t.input_array("a3", dest_array)
        
        t.call("zero_one_loss")
        
        t.check_array(dest_array, [0])
        # t.check_array_pointer("a3", [0])

        t.execute()
        
    def test_standard(self):
        t = AssemblyTest(self, "zero_one_loss.s")

        array0 = t.array([1, 5, 2, 3])
        t.input_array("a0", array0)
        
        array1 = t.array([1, 2, 3, 3])
        t.input_array("a1", array1)
        
        t.input_scalar("a2", 4)
        
        dest_array = t.array([0, 0, 0, 0])
        t.input_array("a3", dest_array)
        
        t.call("zero_one_loss")
        
        t.check_array(dest_array, [1, 0, 0, 1])

        t.execute()

    @classmethod
    def tearDownClass(cls):
        print_coverage("zero_one_loss.s", verbose = False)

"""
initialize_zero
# =======================================================
# FUNCTION: Initialize a zero vector with the given length
# Arguments:
#   a0 (int) size of the vector

# Returns:
#   a0 (int*)  is the pointer to the zero vector
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 36.
# - If malloc fails, this function terminats the program with exit code 26.
# =======================================================
"""
class TestInitializeZero(TestCase):
    def test_length_1(self):
        t = AssemblyTest(self, "initialize_zero.s")

        t.input_scalar("a0", 1)
        t.call("initialize_zero")
        t.check_array_pointer("a0", [0])

        t.execute()
        
    def test_standard(self):
        t = AssemblyTest(self, "initialize_zero.s")
        
        t.input_scalar("a0", 5)
        t.call("initialize_zero")
        t.check_array_pointer("a0", [0, 0, 0, 0, 0])
        
        t.execute()
        
    def test_invalid_n(self):
        t = AssemblyTest(self, "initialize_zero.s")

        t.input_scalar("a0", 0)
        t.call("initialize_zero")
        
        t.execute(code = 36)
        
    def test_malloc_failed(self):
        t = AssemblyTest(self, "initialize_zero.s")
        
        t.input_scalar("a0", 4)
        t.call("initialize_zero")
        
        t.execute(fail = 'malloc', code = 26)

    @classmethod
    def tearDownClass(cls):
        print_coverage("initialize_zero.s", verbose = False)
        