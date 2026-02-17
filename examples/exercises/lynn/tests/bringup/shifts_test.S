// C Runtime entry point
// Eastan Oo
// eoo@g.hmc.edu
// 2/16/2026

.extern return_shifts_test
.extern fail

    .section .text.init
    .globl shifts_test
    .type  shifts_test, @function

shifts_test:
    test1:                  #SLL
        li   t0, 1
        li   t1, 3
        sll  t2, t0, t1
        li   t3, 8
        beq  t2, t3, test2
        j    Fail_SLL

    test2:                 # SLLI
        li   t0, 2
        slli t2, t0, 4
        li   t3, 32
        beq  t2, t3, test3
        j    Fail_SLLI

    test3:                 # SRL
        li   t0, 16
        li   t1, 2
        srl  t2, t0, t1
        li   t3, 4
        beq  t2, t3, test4
        j    Fail_SRL

    test4:                 # SRLI
        li   t0, 32
        srli t2, t0, 3
        li   t3, 4
        beq  t2, t3, test5
        j    Fail_SRLI

    test5:                 # SRA (signed)
        li   t0, -8
        li   t1, 1
        sra  t2, t0, t1
        li   t3, -4
        beq  t2, t3, test6
        j    Fail_SRA

    test6:                 # SRAI
        li   t0, -16
        srai t2, t0, 2
        li   t3, -4
        beq  t2, t3, pass
        j    Fail_SRAI

    pass:
        j return_shifts_test

Fail_SLL:
    li gp, 401
    j fail

Fail_SLLI:
    li gp, 402
    j fail

Fail_SRL:
    li gp, 403
    j fail

Fail_SRLI:
    li gp, 404
    j fail

Fail_SRA:
    li gp, 405
    j fail

Fail_SRAI:
    li gp, 406
    j fail
