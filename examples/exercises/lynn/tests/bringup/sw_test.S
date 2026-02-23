.extern return_sw_test
.extern fail

.section .text.init
.globl sw_test
.type sw_test,@function

sw_test:

    # build t0 = 0x8000_2000
    li  t0, 0x400
    add t0,t0,t0  #1
    add t0,t0,t0  #2
    add t0,t0,t0  #3
    add t0,t0,t0  #4
    add t0,t0,t0  #5
    add t0,t0,t0  #6
    add t0,t0,t0  #7
    add t0,t0,t0  #8
    add t0,t0,t0  #9
    add t0,t0,t0  #10
    add t0,t0,t0  #11
    add t0,t0,t0  #12
    add t0,t0,t0  #13
    add t0,t0,t0  #14
    add t0,t0,t0  #15
    add t0,t0,t0  #16
    add t0,t0,t0  #17
    add t0,t0,t0  #18
    add t0,t0,t0  #19
    add t0,t0,t0  #20
    add t0,t0,t0  #21

    li  t1, 1
    add t1,t1,t1  #1
    add t1,t1,t1  #2
    add t1,t1,t1  #3
    add t1,t1,t1  #4
    add t1,t1,t1  #5
    add t1,t1,t1  #6
    add t1,t1,t1  #7
    add t1,t1,t1  #8
    add t1,t1,t1  #9
    add t1,t1,t1  #10
    add t1,t1,t1  #11
    add t1,t1,t1  #12
    add t1,t1,t1  #13

    add t0, t0, t1

t1_:
    li t2, 77
    sw t2, 0(t0)
    lw t3, 0(t0)
    beq t3, t2, t2_
    j F1

t2_:
    li t2, 88
    sw t2, 4(t0)
    lw t3, 4(t0)
    beq t3, t2, t3_
    j F2

t3_:
    li t2, 99
    sw t2, 8(t0)
    lw t3, 8(t0)
    beq t3, t2, t4_
    j F3

t4_:
    li t2, -2
    sw t2, 12(t0)
    lw t3, 12(t0)
    beq t3, t2, t5_
    j F4

t5_:
    li t2, 123
    sw t2, 16(t0)
    lw t3, 16(t0)
    beq t3, t2, pass
    j F5

pass:
    j return_sw_test

F1: li gp, 1501; j fail
F2: li gp, 1502; j fail
F3: li gp, 1503; j fail
F4: li gp, 1504; j fail
F5: li gp, 1505; j fail
