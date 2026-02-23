// ADDI Test
.extern return_addi_test
.extern fail

.section .text.init
.globl addi_test
.type addi_test, @function

addi_test:
test1:
    li   t0, 5
    addi t1, t0, 7
    li   t2, 12
    beq  t1, t2, test2
    j    Fail_ADDI_1

test2:
    li   t0, -5
    addi t1, t0, -3
    li   t2, -8
    beq  t1, t2, pass
    j    Fail_ADDI_2

pass:
    j return_addi_test

Fail_ADDI_1:
    li gp, 601
    j  fail

Fail_ADDI_2:
    li gp, 602
    j  fail
