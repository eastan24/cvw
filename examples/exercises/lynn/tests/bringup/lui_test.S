.extern return_lui_test
.extern fail

.section .text.init
.globl lui_test
.type lui_test,@function

lui_test:

lui1:
    lui  t0, 0x12345
    li   t1, 0x12345000
    beq  t0, t1, lui2
    j F1

lui2:
    lui  t0, 0xfffff
    li   t1, 0xfffff000
    beq  t0, t1, pass
    j F2

pass:
    j return_lui_test

F1: li gp, 9001; j fail
F2: li gp, 9002; j fail
