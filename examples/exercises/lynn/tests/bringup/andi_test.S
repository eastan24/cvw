.extern return_andi_test
.extern fail

.section .text.init
.globl andi_test
.type andi_test,@function

andi_test:

t1:
    li   t0, 0xF0
    andi t1, t0, 0x0F
    li   t2, 0x00
    beq  t1, t2, t2
    j F1

t2:         # x & 0 = 0
    li   t0, 0x7F
    andi t1, t0, 0
    li   t2, 0
    beq  t1, t2, t3
    j F2

t3:         # x & 0xFF = x (for low 8-bit values)
    li   t0, 0xA5
    andi t1, t0, 0xFF
    beq  t1, t0, t4
    j F3

t4:         # mask keep upper nibble (0xAB & 0xF0 = 0xA0)
    li   t0, 0xAB
    andi t1, t0, 0xF0
    li   t2, 0xA0
    beq  t1, t2, t5
    j F4

t5:         # mask keep lower nibble (0xAB & 0x0F = 0x0B)
    li   t0, 0xAB
    andi t1, t0, 0x0F
    li   t2, 0x0B
    beq  t1, t2, pass
    j F5

pass:
    j return_andi_test

F1: li gp, 1001; j fail
F2: li gp, 1002; j fail
F3: li gp, 1003; j fail
F4: li gp, 1004; j fail
F5: li gp, 1005; j fail
