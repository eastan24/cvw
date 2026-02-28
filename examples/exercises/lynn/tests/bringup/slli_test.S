.extern return_slli_test
.extern fail

.section .text.init
.globl slli_test
.type slli_test,@function

slli_test:

    li t0, 1
    slli t0, t0, 4
    li t1, 16
    beq t0, t1, pass
    j F1

pass:
    j return_slli_test

F1: li gp, 9211; j fail
