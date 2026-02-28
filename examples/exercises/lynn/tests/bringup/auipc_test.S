.extern return_auipc_test
.extern fail

.section .text.init
.globl auipc_test
.type auipc_test,@function

auipc_test:

auipc1:
    # auipc rd, 0 puts the current PC into rd
    # the second auipc is 4 bytes later, so t1 = t0 + 4
    auipc t0, 0       # t0 = PC of this instruction
    auipc t1, 0       # t1 = PC of this instruction = t0 + 4
    addi  t2, t0, 4   # t2 = t0 + 4
    beq   t1, t2, pass
    j F1

pass:
    j return_auipc_test

F1: li gp, 9011; j fail
