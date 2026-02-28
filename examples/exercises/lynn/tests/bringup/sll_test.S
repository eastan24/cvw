.extern return_sll_test
.extern fail

.section .text.init
.globl sll_test
.type sll_test,@function

sll_test:

    li t0, 1
    li t1, 3
    sll t0, t0, t1
    li t2, 8
    beq t0, t2, pass
    j F1

pass:
    j return_sll_test

F1: li gp, 9201; j fail
