.extern return_sb_test
.extern fail

.section .data
mem_sb: .word 0

.section .text.init
.globl sb_test
.type sb_test,@function

sb_test:

    la   t0, mem_sb
    li   t1, 0xAB
    sb   t1, 0(t0)
    lbu  t2, 0(t0)
    beq  t1, t2, pass
    j F1

pass:
    j return_sb_test

F1: li gp, 9401; j fail
