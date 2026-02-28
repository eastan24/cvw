.extern return_srl_test
.extern fail

.section .text.init
.globl srl_test
.type srl_test,@function

srl_test:

srl1:
    li   t0, 16
    li   t1, 2
    srl  t0, t0, t1
    li   t2, 4
    beq  t0, t2, srl2
    j F1

srl2:
    li   t0, 8
    li   t1, 1
    srl  t0, t0, t1
    li   t2, 4
    beq  t0, t2, pass
    j F2

pass:
    j return_srl_test

F1: li gp, 9221; j fail
F2: li gp, 9222; j fail
