.extern return_lb_test
.extern fail

.section .data
mem_lb: .word 0

.section .text.init
.globl lb_test
.type lb_test,@function

lb_test:

    la   t0, mem_lb
    li   t1, 0xFF          # -1 in 8-bit
    sb   t1, 0(t0)
    lb   t2, 0(t0)         # should sign extend → -1
    li   t3, -1
    beq  t2, t3, pass
    j F1

pass:
    j return_lb_test

F1: li gp, 9421; j fail
