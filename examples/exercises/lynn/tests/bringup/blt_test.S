.extern return_blt_test
.extern fail

.section .text.init
.globl blt_test
.type blt_test,@function

blt_test:

    li t0, -1
    li t1, 1
    blt t0, t1, pass
    j F1

pass:
    j return_blt_test

F1: li gp, 9111; j fail
