.extern return_xori_test
.extern fail

.section .text.init
.globl xori_test
.type xori_test,@function

xori_test:

t1:
    li   t0, 0x55
    xori t1, t0, 0xFF
    li   t2, 0xAA
    beq  t1, t2, t2
    j F1

t2:         # x ^ 0 = x
    li   t0, 0x7B
    xori t1, t0, 0
    beq  t1, t0, t3
    j F2

t3:         # x ^ 0xFF flips low 8 bits
    li   t0, 0x00
    xori t1, t0, 0xFF
    li   t2, 0xFF
    beq  t1, t2, t4
    j F3

t4:         # 0xF0 ^ 0x0F = 0xFF
    li   t0, 0xF0
    xori t1, t0, 0x0F
    li   t2, 0xFF
    beq  t1, t2, t5
    j F4

t5:         # (x ^ k) ^ k = x (two xori)
    li   t0, 0x5A
    xori t1, t0, 0x3C
    xori t2, t1, 0x3C
    beq  t2, t0, pass
    j F5

pass:
    j return_xori_test

F1: li gp, 901; j fail
F2: li gp, 902; j fail
F3: li gp, 903; j fail
F4: li gp, 904; j fail
F5: li gp, 905; j fail
