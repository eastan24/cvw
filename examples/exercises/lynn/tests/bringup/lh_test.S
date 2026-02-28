.extern return_lh_test
.extern fail

.section .data
mem_lh: .word 0

.section .text.init
.globl lh_test
.type lh_test,@function

lh_test:

    la   t0, mem_lh
    li   t1, 0xFFFF        # -1 in 16-bit
    sh   t1, 0(t0)
    lh   t2, 0(t0)         # should sign extend → -1
    li   t3, -1
    beq  t2, t3, pass
    j F1

pass:
    j return_lh_test

F1: li gp, 9441; j fail
