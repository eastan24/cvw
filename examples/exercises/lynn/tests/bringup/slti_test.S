.extern return_slti_test
.extern fail

.section .text.init
.globl slti_test
.type slti_test,@function

slti_test:

t1:
    li   t0, 5
    slti t1, t0, 10
    li   t2, 1
    beq  t1, t2, t2
    j F1

t2:         # equal => 0
    li   t0, 5
    slti t1, t0, 5
    li   t2, 0
    beq  t1, t2, t3
    j F2

t3:         # greater => 0
    li   t0, 7
    slti t1, t0, 5
    li   t2, 0
    beq  t1, t2, t4
    j F3

t4:         # negative signed: -1 < 0 => 1
    li   t0, -1
    slti t1, t0, 0
    li   t2, 1
    beq  t1, t2, t5
    j F4

t5:         # 0 < -1 => 0
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
