.extern return_jalr_test
.extern fail

.section .text.init
.globl jalr_test
.type jalr_test,@function

jalr_test:

t1:
    la   t0, target
    jalr ra, 0(t0)
    j F1

target:
    beq ra, zero, F2
    j pass

pass:
    j return_jalr_test

F1: li gp, 9021; j fail
F2: li gp, 9022; j fail
