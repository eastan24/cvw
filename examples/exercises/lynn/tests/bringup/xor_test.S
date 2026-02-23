.extern return_xor_test
.extern fail

.section .text.init
.globl xor_test
.type xor_test, @function

xor_test:
test1:
    li  t0, 0xF0
    li  t1, 0x0F
    xor t2, t0, t1
    li  t3, 0xFF
    beq t2, t3, test2
    j   Fail_XOR_1

test2:
    li    t0, 0xAA
    xori  t1, t0, 0xFF
    li    t2, 0x55
    beq   t1, t2, pass
    j     Fail_XORI_1

pass:
    j return_xor_test

Fail_XOR_1:
    li gp, 701
    j  fail

Fail_XORI_1:
    li gp, 702
    j  fail
