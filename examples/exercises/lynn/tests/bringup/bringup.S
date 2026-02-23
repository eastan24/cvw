// C Runtime entry point
// James Kaden Cassidy
// kacassidy@hmc.edu
// Modified by Eastan Oo
// 1/21/2026

.extern add_test
.extern addi_test
.extern or_test
.extern and_test
.extern xor_test
.extern sub_test
.extern slt_test
.extern mem_test
.extern pass

    .section .text.init
    .globl main
    .globl return_add_test
    .globl return_addi_test
    .globl return_or_test
    .globl return_and_test
    .globl return_xor_test
    .globl return_sub_test
    .globl return_slt_test
    .globl return_mem_test
    .type  main, @function

main:
    j add_test

return_add_test:
    j addi_test

return_addi_test:
    j or_test

return_or_test:
    j and_test

return_and_test:
    j xor_test

return_xor_test:
    j sub_test

return_sub_test:
    j slt_test

return_slt_test:
    j mem_test

return_mem_test:
    j pass
