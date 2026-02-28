.extern return_addi_test
.extern fail

.section .text.init
.globl addi_test
.type addi_test,@function

addi_test:

addi1:
    li   t0, 5
    addi t0, t0, 7
    li   t1, 12
    beq  t0, t1, addi2
    j F1

addi2:
    li   t0, 20
    addi t0, t0, -4
    li   t1, 16
    beq  t0, t1, addi3
    j F2

addi3:
    li   t0, 0
    addi t0, t0, -1
    li   t1, -1
    beq  t0, t1, addi4
    j F3

addi4:
    li   t0, 2047
    li   t1, 2047
    beq  t0, t1, addi5
    j F4

addi5:
    li   t0, -2048
    li   t1, -2048
    beq  t0, t1, pass
    j F5

pass:
    j return_addi_test

F1: li gp, 501; j fail
F2: li gp, 502; j fail
F3: li gp, 503; j fail
F4: li gp, 504; j fail
F5: li gp, 505; j fail
