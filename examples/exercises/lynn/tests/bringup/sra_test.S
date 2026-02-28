.extern return_sra_test
.extern fail

.section .text.init
.globl sra_test
.type sra_test,@function

sra_test:

sra1:
    li   t0, -8
    li   t1, 1
    sra  t0, t0, t1
    li   t2, -4
    beq  t0, t2, sra2
    j F1

sra2:
    li   t0, -1
    li   t1, 5
    sra  t0, t0, t1
    li   t2, -1
    beq  t0, t2, pass
    j F2

pass:
    j return_sra_test

F1: li gp, 9241; j fail
F2: li gp, 9242; j fail
