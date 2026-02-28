.extern return_lhu_test
.extern fail

.section .data
mem_lhu: .word 0

.section .text.init
.globl lhu_test
.type lhu_test,@function

lhu_test:

    la   t0, mem_lhu
    li   t1, 0xFFFF
    sh   t1, 0(t0)
    lhu  t2, 0(t0)         # should zero extend → 65535
    li   t3, 65535
    beq  t2, t3, pass
    j F1

pass:
    j return_lhu_test

F1: li gp, 9451; j fail
