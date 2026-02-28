.extern return_bgeu_test
.extern fail

.section .text.init
.globl bgeu_test
.type bgeu_test,@function

bgeu_test:

    li t0, 5
    li t1, 4
    bgeu t0, t1, pass
    j F1

pass:
    j return_bgeu_test

F1: li gp, 9141; j fail
