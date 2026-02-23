// jal_test.S

.extern return_jal_test
.extern fail

.section .text.init
.globl jal_test
.type jal_test,@function

jal_test:

t1:                 # jal must jump (no fallthrough)
    jal  t0, L1
    j    F1

L1:                 # link reg should be non-zero
    beq  t0, x0, F2
    beq  x0, x0, t2

t2:                 # second jal must jump
    jal  t1, L2
    j    F3

L2:                 # second link reg should be non-zero
    beq  t1, x0, F4
    beq  x0, x0, t3

t3:                 # "j" is jal x0, label — must jump
    j    L3
    j    F5

L3:
    beq  x0, x0, pass

pass:
    j return_jal_test

F1: li gp, 1301; j fail
F2: li gp, 1302; j fail
F3: li gp, 1303; j fail
F4: li gp, 1304; j fail
F5: li gp, 1305; j fail
