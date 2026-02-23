.extern return_xor_test
.extern fail

.section .text.init
.globl xor_test
.type xor_test,@function

xor_test:

t1:         # 0x55 ^ 0xAA = 0xFF
    li  t0, 0x55
    li  t1, 0xAA
    xor t2, t0, t1
    li  t3, 0xFF
    beq t2, t3, t2
    j F1

t2:         # x ^ x = 0
    li  t0, 0x7F
    xor t1, t0, t0
    li  t2, 0
    beq t1, t2, t3
    j F2

t3:         # x ^ 0 = x
    li  t0, 0x33
    xor t1, t0, x0
    beq t1, t0, t4
    j F3

t4:         # 0 ^ x = x
    li  t0, 0x66
    xor t1, x0, t0
    beq t1, t0, t5
    j F4

t5:         # symmetry: a^b == b^a
    li  t0, 0x12
    li  t1, 0x34
    xor t2, t0, t1
    xor t3, t1, t0
    beq t2, t3, pass
    j F5

pass:
    j return_xor_test

F1: li gp, 801; j fail
F2: li gp, 802; j fail
F3: li gp, 803; j fail
F4: li gp, 804; j fail
F5: li gp, 805; j fail
