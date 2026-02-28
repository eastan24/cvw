.extern return_bne_test
.extern fail

.section .text.init
.globl bne_test
.type bne_test,@function

bne_test:

    li t0, 5
    li t1, 6
    bne t0, t1, pass
    j F1

pass:
    j return_bne_test

F1: li gp, 9101; j fail
