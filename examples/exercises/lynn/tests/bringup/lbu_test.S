.extern return_lbu_test
.extern fail

.section .data
mem_lbu: .word 0

.section .text.init
.globl lbu_test
.type lbu_test,@function

lbu_test:

    la   t0, mem_lbu
    li   t1, 0xFF
    sb   t1, 0(t0)
    lbu  t2, 0(t0)         # should zero extend → 255
    li   t3, 255
    beq  t2, t3, pass
    j F1

pass:
    j return_lbu_test

F1: li gp, 9431; j fail
