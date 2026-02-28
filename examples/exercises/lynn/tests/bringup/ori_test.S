.extern return_ori_test
.extern fail

.section .text.init
.globl ori_test
.type ori_test,@function

ori_test:

ori1:
    li  t0, 0x0F
    ori t1, t0, 0xF0
    li  t2, 0xFF
    beq t1, t2, ori2
    j F1

ori2:
    li  t0, 0x5A
    ori t1, t0, 0
    beq t1, t0, ori3
    j F2

ori3:
    li  t0, 0x33
    ori t1, x0, 0
    or  t2, t1, t0
    beq t2, t0, ori4
    j F3

ori4:
    li  t0, 0xA0
    ori t1, t0, 0x0B
    li  t2, 0xAB
    beq t1, t2, ori5
    j F4

ori5:
    li  t0, 0x12
    ori t1, t0, 0x0F
    ori t2, t1, 0x0F
    beq t2, t1, pass
    j F5

pass:
    j return_ori_test

F1: li gp, 1101; j fail
F2: li gp, 1102; j fail
F3: li gp, 1103; j fail
F4: li gp, 1104; j fail
F5: li gp, 1105; j fail
