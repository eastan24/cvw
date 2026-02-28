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
.extern sltu_test
.extern sltiu_test

.extern sll_test
.extern slli_test
.extern srl_test
.extern srli_test
.extern sra_test
.extern srai_test

.extern beq_test
.extern bne_test
.extern blt_test
.extern bltu_test
.extern bge_test
.extern bgeu_test

.extern jal_test
.extern jalr_test

.extern lw_test
.extern sw_test
.extern lb_test
.extern lbu_test
.extern lh_test
.extern lhu_test
.extern sb_test
.extern sh_test

.extern lui_test
.extern auipc_test

.extern pass

    .section .text.init
    .globl main
    .globl return_add_test
    .globl return_addi_test
    .globl return_sub_test
    .globl return_subi_test
    .globl return_slt_test
    .globl return_slti_test
    .globl return_sltu_test
    .globl return_sltiu_test

    .globl return_and_test
    .globl return_andi_test
    .globl return_or_test
    .globl return_ori_test
    .globl return_xor_test
    .globl return_xori_test

    .globl return_sll_test
    .globl return_slli_test
    .globl return_srl_test
    .globl return_srli_test
    .globl return_sra_test
    .globl return_srai_test

    .globl return_beq_test
    .globl return_bne_test
    .globl return_blt_test
    .globl return_bltu_test
    .globl return_bge_test
    .globl return_bgeu_test

    .globl return_jal_test
    .globl return_jalr_test

    .globl return_lw_test
    .globl return_sw_test
    .globl return_lb_test
    .globl return_lbu_test
    .globl return_lh_test
    .globl return_lhu_test
    .globl return_sb_test
    .globl return_sh_test

    .globl return_lui_test
    .globl return_auipc_test
    .type  main, @function

main:
    j add_test


# ------------------------------------------------
# Arithmetic
# ------------------------------------------------

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

return_slti_test:
    j sltu_test

return_sltu_test:
    j sltiu_test


# ------------------------------------------------
# Logical
# ------------------------------------------------

return_sltiu_test:
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


# ------------------------------------------------
# Shifts
# ------------------------------------------------

return_xori_test:
    j sll_test

return_sll_test:
    j slli_test

return_slli_test:
    j srl_test

return_srl_test:
    j srli_test

return_srli_test:
    j sra_test

return_sra_test:
    j srai_test


# ------------------------------------------------
# Branches
# ------------------------------------------------

return_srai_test:
    j beq_test

return_beq_test:
    j bne_test

return_bne_test:
    j blt_test

return_blt_test:
    j bltu_test

return_bltu_test:
    j bge_test

return_bge_test:
    j bgeu_test


# ------------------------------------------------
# Jumps
# ------------------------------------------------

return_bgeu_test:
    j jal_test

return_jal_test:
    j jalr_test


# ------------------------------------------------
# Memory
# ------------------------------------------------

return_jalr_test:
    j lw_test

return_lw_test:
    j sw_test

return_sw_test:
    j lb_test

return_lb_test:
    j lbu_test

return_lbu_test:
    j lh_test

return_lh_test:
    j lhu_test

return_lhu_test:
    j sb_test

return_sb_test:
    j sh_test


# ------------------------------------------------
# Upper Immediate
# ------------------------------------------------

return_sh_test:
    j lui_test

return_lui_test:
    j auipc_test


# ------------------------------------------------
# Done


return_auipc_test:
    j pass
