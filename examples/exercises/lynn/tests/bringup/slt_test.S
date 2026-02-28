.extern return_slt_test
.extern fail

.section .text.init
.globl slt_test
.type slt_test,@function

slt_test:

slt1:
    li  t0, 3
    li  t1, 5
    slt t2, t0, t1
    li  t3, 1
    beq t2, t3, slt2
    j F1

slt2:
    slt t2, t1, t0
    li  t3, 0
    beq t2, t3, slt3
    j F2

slt3:
    li  t0, 9
    li  t1, 9
    slt t2, t0, t1
    li  t3, 0
    beq t2, t3, slt4
    j F3

slt4:
    li  t0, -1
    li  t1, 0
    slt t2, t0, t1
    li  t3, 1
    beq t2, t3, slt5
    j F4

slt5:
    slt t2, t1, t0
    li  t3, 0
    beq t2, t3, pass
    j F5

pass:
    j return_slt_test

F1: li gp, 601; j fail
F2: li gp, 602; j fail
F3: li gp, 603; j fail
F4: li gp, 604; j fail
F5: li gp, 605; j fail
