.extern return_srai_test
.extern fail

.section .text.init
.globl srai_test
.type srai_test,@function

srai_test:

srai1:
    li   t0, -16
    srai t0, t0, 2
    li   t1, -4
    beq  t0, t1, srai2
    j F1

srai2:
    li   t0, 8
    srai t0, t0, 1
    li   t1, 4
    beq  t0, t1, pass
    j F2

pass:
    j return_srai_test

F1: li gp, 9251; j fail
F2: li gp, 9252; j fail
