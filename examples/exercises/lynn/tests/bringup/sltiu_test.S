.extern return_sltiu_test
.extern fail

.section .text.init
.globl sltiu_test
.type sltiu_test,@function

sltiu_test:

sltiu1:
    li    t0, 5
    sltiu t1, t0, 10
    li    t2, 1
    beq   t1, t2, sltiu2
    j F1

sltiu2:
    li    t0, 10
    sltiu t1, t0, 5
    li    t2, 0
    beq   t1, t2, sltiu3
    j F2

sltiu3:
    li    t0, -1
    sltiu t1, t0, 1
    li    t2, 0
    beq   t1, t2, pass
    j F3

pass:
    j return_sltiu_test

F1: li gp, 9311; j fail
F2: li gp, 9312; j fail
F3: li gp, 9313; j fail
