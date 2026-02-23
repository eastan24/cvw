.extern return_ori_test
.extern fail

.section .text.init
.globl ori_test
.type ori_test,@function

ori_test:

t1:
    li  t0, 0x0F
    ori t1, t0, 0xF0
    li  t2, 0xFF
    beq t1, t2, t2
    j F1

t2:         # x | 0 = x
    li  t0, 0x5A
    ori t1, t0, 0
    beq t1, t0, t3
    j F2

t3:         # 0 | x = x (use ori with x0 + imm 0 then or)
    li  t0, 0x33
    ori t1, x0, 0
    or  t2, t1, t0
    beq t2, t0, t4
    j F3

t4:         # set bits: 0xA0 | 0x0B = 0xAB (via ori imm 0x0B)
    li  t0, 0xA0
    ori t1, t0, 0x0B
    li  t2, 0xAB
    beq t1, t2, t5
    j F4

t5:         # idempotent: (x | k) | k = x | k
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
