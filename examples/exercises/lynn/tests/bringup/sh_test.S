.extern return_sh_test
.extern fail

.section .data
mem_sh: .word 0

.section .text.init
.globl sh_test
.type sh_test,@function

sh_test:

    la   t0, mem_sh
    li   t1, 0x1234
    sh   t1, 0(t0)
    lhu  t2, 0(t0)
    beq  t1, t2, pass
    j F1

pass:
    j return_sh_test

F1: li gp, 9411; j fail
