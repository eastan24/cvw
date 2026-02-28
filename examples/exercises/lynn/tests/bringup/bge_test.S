.extern return_bge_test
.extern fail

.section .text.init
.globl bge_test
.type bge_test,@function

bge_test:

    li t0, 5
    li t1, 5
    bge t0, t1, pass
    j F1

pass:
    j return_bge_test

F1: li gp, 9131; j fail
