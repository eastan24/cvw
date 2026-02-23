.extern return_beq_test
.extern fail

.section .text.init
.globl beq_test
.type beq_test,@function

beq_test:

t1:         # taken
    li  t0, 7
    li  t1, 7
    beq t0, t1, t2
    j F1

t2:         # not taken
    li  t0, 1
    li  t1, 2
    beq t0, t1, F2
    j t3

t3:         # compare with x0
    li  t0, 0
    beq t0, x0, t4
    j F3

t4:         # forward branch skips bad code
    li  t0, 5
    li  t1, 5
    beq t0, t1, skip
    j F4
skip:
    beq x0, x0, t5
    j F4

t5:         # backward loop exact 3 iterations
    li  t0, 3
loop:
    addi t0, t0, -1
    beq  t0, x0, pass
    beq  x0, x0, loop

pass:
    j return_beq_test

F1: li gp, 1201; j fail
F2: li gp, 1202; j fail
F3: li gp, 1203; j fail
F4: li gp, 1204; j fail
