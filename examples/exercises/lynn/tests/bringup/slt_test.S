.extern return_slt_test
.extern fail

.section .text.init
.globl slt_test
.type slt_test, @function

slt_test:
test1:
    li  t0, 3
    li  t1, 7
    slt t2, t0, t1
    li  t3, 1
    beq t2, t3, test2
    j   Fail_SLT_1

test2:
    li   t0, -2
    slti t1, t0, 0
    li   t2, 1
    beq  t1, t2, test3
    j    Fail_SLTI_1

test3:
    li  t0, 9
    li  t1, 4
    slt t2, t0, t1
    li  t3, 0
    beq t2, t3, pass
    j   Fail_SLT_2

pass:
    j return_slt_test

Fail_SLT_1:
    li gp, 801
    j  fail

Fail_SLTI_1:
    li gp, 802
    j  fail

Fail_SLT_2:
    li gp, 803
    j  fail
