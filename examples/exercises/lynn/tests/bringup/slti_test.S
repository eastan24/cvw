.extern return_slti_test
.extern fail

.section .text.init
.globl slti_test
.type slti_test,@function

slti_test:

slti1:
    li   t0, 5
    slti t1, t0, 10
    li   t2, 1
    beq  t1, t2, slti2
    j F1

slti2:
    li   t0, 5
    slti t1, t0, 5
    li   t2, 0
    beq  t1, t2, slti3
    j F2

slti3:
    li   t0, 7
    slti t1, t0, 5
    li   t2, 0
    beq  t1, t2, slti4
    j F3

slti4:
    li   t0, -1
    slti t1, t0, 0
    li   t2, 1
    beq  t1, t2, slti5
    j F4

slti5:
    li   t0, 0
    slti t1, t0, -1
    li   t2, 0
    beq  t1, t2, pass
    j F5

pass:
    j return_slti_test

F1: li gp, 701; j fail
F2: li gp, 702; j fail
F3: li gp, 703; j fail
F4: li gp, 704; j fail
F5: li gp, 705; j fail
