.extern return_mem_test
.extern fail

.section .text.init
.globl mem_test
.type mem_test, @function

mem_test:
    li   t0, 123

    # safe RAM address far away from code
    li   t1, 0x80002000

    sw   t0, 0(t1)
    lw   t2, 0(t1)

    beq  t0, t2, pass
    j    Fail_MEM_1

pass:
    j return_mem_test

Fail_MEM_1:
    li gp, 901
    j  fail
