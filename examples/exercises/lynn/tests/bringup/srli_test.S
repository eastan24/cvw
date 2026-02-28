.extern return_srli_test
.extern fail

.section .text.init
.globl srli_test
.type srli_test,@function

srli_test:

srli1:
    li   t0, 16
    srli t0, t0, 2
    li   t1, 4
    beq  t0, t1, srli2
    j F1

srli2:
    li   t0, 0x80000000
    srli t0, t0, 1
    li   t1, 0x40000000
    beq  t0, t1, pass
    j F2

pass:
    j return_srli_test

F1: li gp, 9231; j fail
F2: li gp, 9232; j fail
