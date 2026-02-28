.extern return_sltu_test
.extern fail

.section .text.init
.globl sltu_test
.type sltu_test,@function

sltu_test:

    li t0, -1
    li t1, 1
    sltu t2, t0, t1
    li t3, 0
    beq t2, t3, pass
    j F1

pass:
    j return_sltu_test

F1: li gp, 9301; j fail
