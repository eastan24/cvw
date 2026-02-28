.extern return_bltu_test
.extern fail

.section .text.init
.globl bltu_test
.type bltu_test,@function

bltu_test:

    li t0, 1
    li t1, 2
    bltu t0, t1, pass
    j F1

pass:
    j return_bltu_test

F1: li gp, 9121; j fail
