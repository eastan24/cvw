.extern return_subi_test
.extern fail

.section .text.init
.globl subi_test
.type subi_test,@function

subi_test:

subi1:
    li   t0, 20
    addi t0, t0, -1
    li   t1, 19
    beq  t0, t1, subi2
    j F1

subi2:
    li   t0, 0
    addi t0, t0, -1
    li   t1, -1
    beq  t0, t1, subi3
    j F2

subi3:
    li   t0, -5
    addi t0, t0, -5
    li   t1, -10
    beq  t0, t1, subi4
    j F3

subi4:
    li   t0, 100
    addi t0, t0, -100
    li   t1, 0
    beq  t0, t1, subi5
    j F4

subi5:
    li   t0, 7
    addi t0, t0, -9
    li   t1, -2
    beq  t0, t1, pass
    j F5

pass:
    j return_subi_test

F1: li gp, 1601; j fail
F2: li gp, 1602; j fail
F3: li gp, 1603; j fail
F4: li gp, 1604; j fail
F5: li gp, 1605; j fail
