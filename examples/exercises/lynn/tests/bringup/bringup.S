// C Runtime entry point
// James Kaden Cassidy
// kacassidy@hmc.edu
// Modified by Eastan Oo
// 1/21/2026

.extern add_test
.extern addi_test
.extern sub_test
.extern subi_test
.extern and_test
.extern andi_test
.extern or_test
.extern ori_test
.extern xor_test
.extern xori_test
.extern slt_test
.extern slti_test
.extern beq_test
.extern jal_test
.extern lw_test
.extern sw_test
.extern pass

    .section .text.init
    .globl main
    .globl return_add_test
    .globl return_addi_test
    .globl return_sub_test
    .globl return_subi_test
    .globl return_and_test
    .globl return_andi_test
    .globl return_or_test
    .globl return_ori_test
    .globl return_xor_test
    .globl return_xori_test
    .globl return_slt_test
    .globl return_slti_test
    .globl return_beq_test
    .globl return_jal_test
    .globl return_lw_test
    .globl return_sw_test
    .type  main, @function

main:
    j add_test


# Arithmetic

return_add_test:
    j addi_test

return_addi_test:
    j sub_test

return_sub_test:
    j subi_test

return_subi_test:
    j slt_test

return_slt_test:
    j slti_test

# Logical (register + immediate)

return_slti_test:
    j and_test

return_and_test:
    j andi_test

return_andi_test:
    j or_test

return_or_test:
    j ori_test

return_ori_test:
    j xor_test

return_xor_test:
    j xori_test


# Control Flow

return_xori_test:
    j beq_test

return_beq_test:
    j jal_test


# Memory

return_jal_test:
    j lw_test

return_lw_test:
    j sw_test

return_sw_test:
    j pass
